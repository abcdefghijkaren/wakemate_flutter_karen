import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';
import 'CaffeineRecommendationPage.dart';

class CaffeineHistoryPage extends StatefulWidget {
  final String userId;
  final DateTime selectedDate;

  const CaffeineHistoryPage({
    super.key,
    required this.userId,
    required this.selectedDate,
  });

  @override
  State<CaffeineHistoryPage> createState() => _CaffeineHistoryPageState();
}

class _CaffeineHistoryPageState extends State<CaffeineHistoryPage> {
  final Color _primaryColor = const Color(0xFF1F3D5B);
  final Color _accentColor = const Color(0xFF5E91B3);
  final Color _backgroundColor = const Color(0xFFF0F2F5);
  final Color _cardColor = Colors.white;
  final Color _textColor = const Color(0xFF424242);

  List<dynamic> _allData = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  String _selectedDateStr() {
    return DateFormat('yyyy-MM-dd').format(widget.selectedDate);
  }

  Future<void> _loadData() async {
    if (mounted) setState(() => _loading = true);

    final prefs = await SharedPreferences.getInstance();
    final dataStr = prefs.getString('caffeine_recommendations') ?? '[]';

    try {
      final List<dynamic> data =
          dataStr.isNotEmpty ? List<dynamic>.from(jsonDecode(dataStr)) : [];

      if (mounted) {
        setState(() {
          _allData = data;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _allData = [];
          _loading = false;
        });
      }
    }
  }

  Future<void> _clearDataForSelectedDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dataStr = prefs.getString('caffeine_recommendations') ?? '[]';
    List<dynamic> data = dataStr.isNotEmpty ? jsonDecode(dataStr) : [];

    final String selectedDateStr = _selectedDateStr();

    data = data.where((item) {
      final String? displayDate = item['display_date']?.toString();

      // ⭐ 新版資料：優先用 display_date 刪
      if (displayDate != null && displayDate.isNotEmpty) {
        return displayDate != selectedDateStr;
      }

      // ⭐ 舊版資料：退回舊邏輯
      final String timingStr =
          item['recommended_caffeine_intake_timing'] ?? '';
      if (timingStr.isEmpty) return true;

      final DateTime? localDateTime = _parseAndLocalize(timingStr);
      if (localDateTime == null) return true;

      final String itemDateStr =
          DateFormat('yyyy-MM-dd').format(localDateTime);

      return itemDateStr != selectedDateStr;
    }).toList();

    await prefs.setString('caffeine_recommendations', jsonEncode(data));

    setState(() {
      _allData = data;
    });
  }

  DateTime? _parseAndLocalize(String? datetimeStr) {
    if (datetimeStr == null || datetimeStr.isEmpty) return null;
    try {
      return DateTime.parse(datetimeStr).toLocal();
    } catch (e) {
      return null;
    }
  }

  List<dynamic> _filterSelectedDateData() {
    if (_allData.isEmpty) return [];

    final String selectedDateStr = _selectedDateStr();

    return _allData.where((item) {
      final String? displayDate = item['display_date']?.toString();

      // ⭐ 新版資料：優先用 display_date 顯示
      if (displayDate != null && displayDate.isNotEmpty) {
        return displayDate == selectedDateStr;
      }

      // ⭐ 舊版資料：退回舊邏輯
      final String timingStr =
          item['recommended_caffeine_intake_timing'] ?? '';
      if (timingStr.isEmpty) return false;

      final DateTime? localDateTime = _parseAndLocalize(timingStr);
      if (localDateTime == null) return false;

      final String itemDateStr =
          DateFormat('yyyy-MM-dd').format(localDateTime);

      return itemDateStr == selectedDateStr;
    }).toList();
  }

  Widget _buildDataRow({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      children: [
        Icon(icon, color: _accentColor, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            "$title：$content",
            style: TextStyle(fontSize: 16, color: _textColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final historyForSelectedDate = _filterSelectedDateData();
    final hasHistory = historyForSelectedDate.isNotEmpty;
    final formattedDate =
        DateFormat('yyyy/MM/dd').format(widget.selectedDate);

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          loc.caffeineHistoryTitle(formattedDate),
          style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : hasHistory
              ? ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: historyForSelectedDate.length,
                  itemBuilder: (context, index) {
                    final item = historyForSelectedDate[index];

                    final recommendedTimingStr =
                        item['recommended_caffeine_intake_timing'] ?? '';
                    final recommendedAmount =
                        item['recommended_caffeine_amount'] ?? '';
                    final displayStatus =
                        item['display_status'] ?? 'active';
                    final fetchedAt = item['fetched_at'];

                    final localDateTime =
                        _parseAndLocalize(recommendedTimingStr);

                    final formattedTime = localDateTime != null
                        ? DateFormat('MM/dd HH:mm').format(localDateTime)
                        : loc.formatError;

                    return Card(
                      color: _cardColor,
                      elevation: 4.0,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    loc.caffeineSuggestionIndex(index + 1),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: displayStatus == 'active'
                                        ? Colors.green.withOpacity(0.15)
                                        : Colors.orange.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    displayStatus == 'active'
                                        ? loc.activeStatus
                                        : loc.expiredStatus,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: displayStatus == 'active'
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildDataRow(
                              icon: Icons.access_time_filled,
                              title: loc.recommendedTime,
                              content: formattedTime,
                            ),
                            const SizedBox(height: 12),
                            _buildDataRow(
                              icon: Icons.local_cafe,
                              title: loc.recommendedAmount,
                              content:
                                  loc.amountMg(recommendedAmount.toString()),
                            ),
                            if (fetchedAt != null) ...[
                              const SizedBox(height: 12),
                              _buildDataRow(
                                icon: Icons.update,
                                title: loc.updatedTime,
                                content: DateFormat('MM/dd HH:mm')
                                    .format(DateTime.parse(fetchedAt).toLocal()),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.coffee_outlined,
                          size: 80,
                          color: _accentColor.withOpacity(0.5),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          loc.noCaffeineHistory(formattedDate),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: _textColor.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          loc.clickToGenerate,
                          style: TextStyle(
                            fontSize: 16,
                            color: _textColor.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await _clearDataForSelectedDate();

                            if (mounted) {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaffeineRecommendationPage(
                                    userId: widget.userId,
                                    selectedDate: widget.selectedDate,
                                  ),
                                ),
                              );

                              if (result == true || result == null) {
                                await _loadData();
                                if (mounted) setState(() {});
                              }
                            }
                          },
                          icon: const Icon(Icons.auto_graph),
                          label: Text(loc.recalculate),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}