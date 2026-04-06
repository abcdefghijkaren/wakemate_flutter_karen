import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';

// --- 數據模型 ---
class UserDayData {
  final List<dynamic> wakePeriods;
  final List<dynamic> sleepCycles;
  final List<dynamic> caffeineIntakes;

  UserDayData({
    required this.wakePeriods,
    required this.sleepCycles,
    required this.caffeineIntakes,
  });

  bool get isEmpty =>
      wakePeriods.isEmpty && sleepCycles.isEmpty && caffeineIntakes.isEmpty;
}

class UserInputHistoryPage extends StatefulWidget {
  final String userId;
  final DateTime selectedDate;

  const UserInputHistoryPage({
    super.key,
    required this.userId,
    required this.selectedDate,
  });

  @override
  State<UserInputHistoryPage> createState() => _UserInputHistoryPageState();
}

class _UserInputHistoryPageState extends State<UserInputHistoryPage> {
  final Color _primaryColor = const Color(0xFF1F3D5B);
  final Color _accentColor = const Color(0xFF5E91B3);
  final Color _backgroundColor = const Color(0xFFF0F2F5);
  final Color _cardColor = Colors.white;
  final Color _textColor = const Color(0xFF424242);
  final String baseUrl = 'https://wakemate-api-4-0.onrender.com';

  late Future<UserDayData> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserInputHistory();
  }

  DateTime? _parseAndLocalize(String? datetimeStr) {
    if (datetimeStr == null || datetimeStr.isEmpty) return null;
    try {
      return DateTime.parse(datetimeStr).toLocal();
    } catch (e) {
      print('Error parsing time: $e');
      return null;
    }
  }

  bool _isPointInSelectedDate(
    DateTime point,
    DateTime dateStart,
    DateTime dateEnd,
  ) {
    return !point.isBefore(dateStart) && point.isBefore(dateEnd);
  }

  bool _doesRangeOverlapSelectedDate(
    DateTime start,
    DateTime end,
    DateTime dateStart,
    DateTime dateEnd,
  ) {
    return start.isBefore(dateEnd) && end.isAfter(dateStart);
  }

  Future<List<dynamic>> _fetchData(
    String endpoint,
    String userId,
    String dateQuery,
  ) async {
    try {
      final url = '$baseUrl/$endpoint/?user_id=$userId&date=$dateQuery';
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        return json.decode(decodedBody) as List<dynamic>;
      } else {
        final String decodedErrorBody = utf8.decode(response.bodyBytes);
        print('API Error for $endpoint: ${response.statusCode}');
        print('API Error Body: $decodedErrorBody');
        return [];
      }
    } catch (e) {
      print('Network Error for $endpoint: $e');
      throw Exception('Failed to connect to $endpoint: $e');
    }
  }

  Future<UserDayData> _fetchUserInputHistory() async {
    final dateQuery = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    final userId = widget.userId;

    final List<List<dynamic>> rawResults = await Future.wait([
      _fetchData('users_wake', userId, dateQuery).catchError((_) => []),
      _fetchData('users_sleep', userId, dateQuery).catchError((_) => []),
      _fetchData('users_intake', userId, dateQuery).catchError((_) => []),
    ]);

    final rawWakePeriods = rawResults[0];
    final rawSleepCycles = rawResults[1];
    final rawCaffeineIntakes = rawResults[2];

    final dateStart = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
    );
    final dateEnd = dateStart.add(const Duration(days: 1));

    final filteredWake =
        rawWakePeriods.where((item) {
          final localStart =
              _parseAndLocalize(item['target_start_time'] as String?);
          final localEnd =
              _parseAndLocalize(item['target_end_time'] as String?);

          if (localStart == null || localEnd == null) return false;

          return _doesRangeOverlapSelectedDate(
            localStart,
            localEnd,
            dateStart,
            dateEnd,
          );
        }).toList();

    final filteredSleep =
        rawSleepCycles.where((item) {
          final localStart =
              _parseAndLocalize(item['sleep_start_time'] as String?);
          final localEnd =
              _parseAndLocalize(item['sleep_end_time'] as String?);

          if (localStart == null || localEnd == null) return false;

          return _doesRangeOverlapSelectedDate(
            localStart,
            localEnd,
            dateStart,
            dateEnd,
          );
        }).toList();

    final filteredIntake =
        rawCaffeineIntakes.where((item) {
          final localTake =
              _parseAndLocalize(item['taking_timestamp'] as String?);

          if (localTake == null) return false;

          return _isPointInSelectedDate(localTake, dateStart, dateEnd);
        }).toList();

    return UserDayData(
      wakePeriods: filteredWake,
      sleepCycles: filteredSleep,
      caffeineIntakes: filteredIntake,
    );
  }

  Widget _buildDataRow({
    required IconData icon,
    required String title,
    required String content,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(
              "$title:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _textColor.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(fontSize: 14, color: _textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        children: [
          Icon(icon, color: _primaryColor, size: 28),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard({
    required String title,
    required IconData icon,
    required List<dynamic> dataList,
    required String isEmptyMessage,
    required Widget Function(dynamic item) buildItem,
  }) {
    return Card(
      color: _cardColor,
      elevation: 2.0,
      margin: const EdgeInsets.only(top: 8, bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: _primaryColor, size: 22),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            if (dataList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  isEmptyMessage,
                  style: TextStyle(color: _textColor.withOpacity(0.5)),
                ),
              )
            else
              ...dataList.map((item) => buildItem(item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySection(
    IconData icon,
    String message,
    String subMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
      child: Column(
        children: [
          Icon(icon, size: 80, color: _accentColor.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textColor.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subMessage,
            style: TextStyle(fontSize: 14, color: _textColor.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final String formattedDate =
        DateFormat('yyyy/MM/dd').format(widget.selectedDate);

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          loc.userInputHistoryTitle(formattedDate),
          style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<UserDayData>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: _primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    loc.loadingUserInputData,
                    style: TextStyle(color: _textColor),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return _buildEmptySection(
              Icons.error_outline,
              loc.userInputLoadError(snapshot.error.toString()),
              loc.returnHomeAndAddRecord,
            );
          } else if (snapshot.hasData) {
            final UserDayData userData = snapshot.data!;

            if (userData.isEmpty) {
              return Center(
                child: _buildEmptySection(
                  Icons.sentiment_dissatisfied,
                  loc.noUserInputOnThisDay,
                  loc.returnHomeAndAddRecord,
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                _buildSectionTitle(
                  Icons.person_pin_outlined,
                  loc.yourInputHistory,
                ),

                _buildInputCard(
                  title: loc.actualSleepCycle,
                  icon: Icons.bedtime_outlined,
                  dataList: userData.sleepCycles,
                  isEmptyMessage: loc.noActualSleepRecord,
                  buildItem: (item) {
                    final start =
                        _parseAndLocalize(item['sleep_start_time'] as String?);
                    final end =
                        _parseAndLocalize(item['sleep_end_time'] as String?);

                    if (start == null || end == null) return const SizedBox();

                    final duration = end.difference(start);
                    final hours = duration.inHours;
                    final minutes = duration.inMinutes % 60;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDataRow(
                          icon: Icons.arrow_right_alt,
                          title: loc.startTime,
                          content: DateFormat('MM/dd HH:mm').format(start),
                          iconColor: _accentColor,
                        ),
                        _buildDataRow(
                          icon: Icons.arrow_right_alt,
                          title: loc.endTime,
                          content: DateFormat('MM/dd HH:mm').format(end),
                          iconColor: _accentColor,
                        ),
                        _buildDataRow(
                          icon: Icons.timer,
                          title: loc.totalDuration,
                          content: loc.durationHoursMinutes(hours, minutes),
                          iconColor: _accentColor,
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),

                _buildInputCard(
                  title: loc.targetWakePeriod,
                  icon: Icons.access_time_filled,
                  dataList: userData.wakePeriods,
                  isEmptyMessage: loc.noTargetWakePeriodRecord,
                  buildItem: (item) {
                    final start = _parseAndLocalize(
                      item['target_start_time'] as String?,
                    );
                    final end = _parseAndLocalize(
                      item['target_end_time'] as String?,
                    );

                    if (start == null || end == null) return const SizedBox();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDataRow(
                          icon: Icons.wb_sunny_outlined,
                          title: loc.startTime,
                          content: DateFormat('MM/dd HH:mm').format(start),
                          iconColor: _accentColor,
                        ),
                        _buildDataRow(
                          icon: Icons.wb_sunny_outlined,
                          title: loc.endTime,
                          content: DateFormat('MM/dd HH:mm').format(end),
                          iconColor: _accentColor,
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),

                _buildInputCard(
                  title: loc.caffeineIntake,
                  icon: Icons.local_cafe_outlined,
                  dataList: userData.caffeineIntakes,
                  isEmptyMessage: loc.noCaffeineIntakeRecord,
                  buildItem: (item) {
                    final time =
                        _parseAndLocalize(item['taking_timestamp'] as String?);
                    final amount = item['caffeine_amount']?.toString() ??
                        loc.notAvailable;
                    final name =
                        item['drink_name']?.toString() ?? loc.unknownDrink;

                    if (time == null) return const SizedBox();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDataRow(
                          icon: Icons.schedule,
                          title: loc.intakeTime,
                          content: DateFormat('MM/dd HH:mm').format(time),
                          iconColor: _accentColor,
                        ),
                        _buildDataRow(
                          icon: Icons.spa,
                          title: loc.contentLabel,
                          content: loc.drinkWithAmount(name, amount),
                          iconColor: _accentColor,
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}