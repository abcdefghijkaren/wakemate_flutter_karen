import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';

class UserDayData {
  final List<Map<String, dynamic>> wakePeriods; // merged groups
  final List<Map<String, dynamic>> sleepCycles; // merged groups
  final List<dynamic> caffeineIntakes; // original records

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
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserInputHistory();
  }

  void _reloadPage() {
    setState(() {
      _userDataFuture = _fetchUserInputHistory();
    });
  }

  AppLocalizations get loc => AppLocalizations.of(context)!;

  // ========= 新增字串集中區 =========
  String get _editText => loc.edit;
  String get _deleteText => loc.delete;
  String get _cancelText => loc.cancel;
  String get _saveText => loc.save;

  String get _deleteDialogTitle => loc.deleteRecordTitle;
  String get _deleteDialogMessage => loc.deleteRecordMessage;

  String get _editSleepTitle => loc.editSleepRecord;
  String get _editWakeTitle => loc.editWakePeriod;
  String get _editIntakeTitle => loc.editCaffeineIntake;

  String get _startTimeLabel => loc.startTime;
  String get _endTimeLabel => loc.endTime;
  String get _intakeTimeLabel => loc.intakeTimeLabel;
  String get _drinkNameLabel => loc.drinkNameLabel;
  String get _caffeineAmountLabel => loc.caffeineAmountLabel;
  String get _dateTimeHint => loc.dateTimeHint;

  String get _deleteSuccessText => loc.deletedSuccessfully;
  String get _updateSuccessText => loc.updatedSuccessfully;
  String get _deleteFailedText => loc.deleteFailed;
  String get _updateFailedText => loc.updateFailed;

  String get _invalidDateTimeText => loc.invalidDateTimeFormat;
  String get _invalidAmountText => loc.invalidCaffeineAmount;
  String get _emptyDrinkNameText => loc.emptyDrinkName;
  String get _endMustBeLaterText => loc.endTimeMustBeLater;

  String _mergedFromText(int count) => loc.mergedFromRecords(count);
  String get _singleRecordText => loc.singleRecordCount;
  String get _originalRecordText => loc.originalRecord;
  // ================================

  DateTime? _parseUserInputTime(String? datetimeStr) {
    if (datetimeStr == null || datetimeStr.trim().isEmpty) return null;

    try {
      final raw = datetimeStr.trim();

      final hasTimezone = raw.endsWith('Z') ||
          RegExp(r'([+-]\d{2}:\d{2})$').hasMatch(raw);

      final parsed = DateTime.parse(raw);

      // 顯示使用者輸入的牆上時間
      if (hasTimezone) {
        final utc = parsed.toUtc();
        return DateTime(
          utc.year,
          utc.month,
          utc.day,
          utc.hour,
          utc.minute,
          utc.second,
          utc.millisecond,
          utc.microsecond,
        );
      }

      return parsed;
    } catch (e) {
      debugPrint('Error parsing user input time: $datetimeStr, error: $e');
      return null;
    }
  }

  String _formatDateTime(DateTime dt) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dt);
  }

  String _formatDisplayTime(DateTime dt) {
    return DateFormat('MM/dd HH:mm').format(dt);
  }

  DateTime? _parseEditorDateTime(String raw) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm').parseStrict(raw.trim());
    } catch (_) {
      return null;
    }
  }

  String _toApiDateTimeString(DateTime dt) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dt);
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
        final decodedBody = utf8.decode(response.bodyBytes);
        return json.decode(decodedBody) as List<dynamic>;
      } else {
        final decodedErrorBody = utf8.decode(response.bodyBytes);
        debugPrint('API Error for $endpoint: ${response.statusCode}');
        debugPrint('API Error Body: $decodedErrorBody');
        return [];
      }
    } catch (e) {
      debugPrint('Network Error for $endpoint: $e');
      throw Exception('Failed to connect to $endpoint: $e');
    }
  }

  List<Map<String, dynamic>> _mergeTimeRanges({
    required List<dynamic> rawList,
    required String startKey,
    required String endKey,
  }) {
    final List<Map<String, dynamic>> parsedRanges = [];

    for (final item in rawList) {
      final start = _parseUserInputTime(item[startKey] as String?);
      final end = _parseUserInputTime(item[endKey] as String?);

      if (start == null || end == null) continue;
      if (!end.isAfter(start)) continue;

      parsedRanges.add({
        'start': start,
        'end': end,
        'sourceItems': [item],
      });
    }

    if (parsedRanges.isEmpty) return [];

    parsedRanges.sort(
      (a, b) => (a['start'] as DateTime).compareTo(b['start'] as DateTime),
    );

    final List<Map<String, dynamic>> merged = [];

    for (final current in parsedRanges) {
      if (merged.isEmpty) {
        merged.add(current);
        continue;
      }

      final last = merged.last;
      final lastEnd = last['end'] as DateTime;
      final currentStart = current['start'] as DateTime;
      final currentEnd = current['end'] as DateTime;

      // 你的規則：若下一段 start <= 目前段 end，合併
      if (!currentStart.isAfter(lastEnd)) {
        if (currentEnd.isAfter(lastEnd)) {
          last['end'] = currentEnd;
        }
        (last['sourceItems'] as List).addAll(current['sourceItems'] as List);
      } else {
        merged.add(current);
      }
    }

    return merged;
  }

  Future<UserDayData> _fetchUserInputHistory() async {
    final dateQuery = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    final userId = widget.userId;

    final rawResults = await Future.wait([
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

    final filteredWake = rawWakePeriods.where((item) {
      if (item['is_active'] == false) return false;

      final start = _parseUserInputTime(item['target_start_time'] as String?);
      final end = _parseUserInputTime(item['target_end_time'] as String?);

      if (start == null || end == null) return false;

      return _doesRangeOverlapSelectedDate(start, end, dateStart, dateEnd);
    }).toList();

    final filteredSleep = rawSleepCycles.where((item) {
      if (item['is_active'] == false) return false;

      final start = _parseUserInputTime(item['sleep_start_time'] as String?);
      final end = _parseUserInputTime(item['sleep_end_time'] as String?);

      if (start == null || end == null) return false;

      return _doesRangeOverlapSelectedDate(start, end, dateStart, dateEnd);
    }).toList();

    final filteredIntake = rawCaffeineIntakes.where((item) {
      if (item['is_active'] == false) return false;

      final take = _parseUserInputTime(item['taking_timestamp'] as String?);
      if (take == null) return false;

      return _isPointInSelectedDate(take, dateStart, dateEnd);
    }).toList();

    filteredIntake.sort((a, b) {
      final ta = _parseUserInputTime(a['taking_timestamp'] as String?);
      final tb = _parseUserInputTime(b['taking_timestamp'] as String?);
      if (ta == null || tb == null) return 0;
      return ta.compareTo(tb);
    });

    return UserDayData(
      wakePeriods: _mergeTimeRanges(
        rawList: filteredWake,
        startKey: 'target_start_time',
        endKey: 'target_end_time',
      ),
      sleepCycles: _mergeTimeRanges(
        rawList: filteredSleep,
        startKey: 'sleep_start_time',
        endKey: 'sleep_end_time',
      ),
      caffeineIntakes: filteredIntake,
    );
  }

  Uri _getEntryUri(String type, dynamic item) {
    final id = item['id'];
    switch (type) {
      case 'sleep':
        return Uri.parse('$baseUrl/users_sleep/$id');
      case 'wake':
        return Uri.parse('$baseUrl/users_wake/$id');
      case 'intake':
        return Uri.parse('$baseUrl/users_intake/$id');
      default:
        throw Exception('Unknown type: $type');
    }
  }

  Future<void> _deleteRecord({
    required String type,
    required dynamic item,
  }) async {
    final id = item['id'];
    if (id == null) {
      _showSnackBar('$_deleteFailedText: missing id');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final uri = _getEntryUri(type, item);

      final response = await http.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _showSnackBar(_deleteSuccessText, color: Colors.green);
        _reloadPage();
      } else {
        final body = utf8.decode(response.bodyBytes);
        _showSnackBar('$_deleteFailedText: ${response.statusCode} $body');
      }
    } catch (e) {
      _showSnackBar('$_deleteFailedText: $e');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _updateRecord({
    required String type,
    required dynamic item,
    required Map<String, dynamic> body,
  }) async {
    final id = item['id'];
    if (id == null) {
      _showSnackBar('$_updateFailedText: missing id');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final uri = _getEntryUri(type, item);

      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _showSnackBar(_updateSuccessText, color: Colors.green);
        _reloadPage();
      } else {
        final resBody = utf8.decode(response.bodyBytes);
        _showSnackBar('$_updateFailedText: ${response.statusCode} $resBody');
      }
    } catch (e) {
      _showSnackBar('$_updateFailedText: $e');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showSnackBar(String message, {Color color = Colors.red}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> _confirmDelete({
    required String type,
    required dynamic item,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(_deleteDialogTitle),
          content: Text(_deleteDialogMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(_cancelText),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(_deleteText),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _deleteRecord(type: type, item: item);
    }
  }

  Future<void> _showEditDialog({
    required String type,
    required dynamic item,
  }) async {
    if (type == 'sleep' || type == 'wake') {
      final startKey =
          type == 'sleep' ? 'sleep_start_time' : 'target_start_time';
      final endKey = type == 'sleep' ? 'sleep_end_time' : 'target_end_time';

      final currentStart = _parseUserInputTime(item[startKey] as String?);
      final currentEnd = _parseUserInputTime(item[endKey] as String?);

      final startController = TextEditingController(
        text: currentStart != null ? _formatDateTime(currentStart) : '',
      );
      final endController = TextEditingController(
        text: currentEnd != null ? _formatDateTime(currentEnd) : '',
      );

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(type == 'sleep' ? _editSleepTitle : _editWakeTitle),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: startController,
                    decoration: InputDecoration(
                      labelText: _startTimeLabel,
                      hintText: _dateTimeHint,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: endController,
                    decoration: InputDecoration(
                      labelText: _endTimeLabel,
                      hintText: _dateTimeHint,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(_cancelText),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(_saveText),
              ),
            ],
          );
        },
      );

      if (confirmed != true) return;

      final start = _parseEditorDateTime(startController.text);
      final end = _parseEditorDateTime(endController.text);

      if (start == null || end == null) {
        _showSnackBar(_invalidDateTimeText);
        return;
      }

      if (!end.isAfter(start)) {
        _showSnackBar(_endMustBeLaterText);
        return;
      }

      final body = {
        startKey: _toApiDateTimeString(start),
        endKey: _toApiDateTimeString(end),
      };

      await _updateRecord(type: type, item: item, body: body);
      return;
    }

    if (type == 'intake') {
      final currentTime =
          _parseUserInputTime(item['taking_timestamp'] as String?);
      final currentAmount = item['caffeine_amount']?.toString() ?? '';
      final currentDrink = item['drink_name']?.toString() ?? '';

      final timeController = TextEditingController(
        text: currentTime != null ? _formatDateTime(currentTime) : '',
      );
      final amountController = TextEditingController(text: currentAmount);
      final drinkController = TextEditingController(text: currentDrink);

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(_editIntakeTitle),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: _intakeTimeLabel,
                      hintText: _dateTimeHint,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: drinkController,
                    decoration: InputDecoration(
                      labelText: _drinkNameLabel,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: _caffeineAmountLabel,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(_cancelText),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(_saveText),
              ),
            ],
          );
        },
      );

      if (confirmed != true) return;

      final time = _parseEditorDateTime(timeController.text);
      final amount = int.tryParse(amountController.text.trim());
      final drinkName = drinkController.text.trim();

      if (time == null) {
        _showSnackBar(_invalidDateTimeText);
        return;
      }
      if (amount == null || amount < 0) {
        _showSnackBar(_invalidAmountText);
        return;
      }
      if (drinkName.isEmpty) {
        _showSnackBar(_emptyDrinkNameText);
        return;
      }

      final body = {
        'taking_timestamp': _toApiDateTimeString(time),
        'drink_name': drinkName,
        'caffeine_amount': amount,
      };

      await _updateRecord(type: 'intake', item: item, body: body);
    }
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

  Widget _buildActionButtons({
    required String type,
    required dynamic item,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: _isSubmitting
              ? null
              : () => _showEditDialog(type: type, item: item),
          icon: const Icon(Icons.edit_outlined, size: 18),
          label: Text(_editText),
        ),
        TextButton.icon(
          onPressed: _isSubmitting
              ? null
              : () => _confirmDelete(type: type, item: item),
          icon: const Icon(Icons.delete_outline, size: 18),
          label: Text(_deleteText),
        ),
      ],
    );
  }

  Widget _buildSourceRecordTile({
    required String type,
    required dynamic item,
    required String startKey,
    required String endKey,
  }) {
    final start = _parseUserInputTime(item[startKey] as String?);
    final end = _parseUserInputTime(item[endKey] as String?);

    if (start == null || end == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _originalRecordText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: _textColor.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 6),
          _buildDataRow(
            icon: Icons.schedule,
            title: loc.startTime,
            content: _formatDisplayTime(start),
            iconColor: _accentColor,
          ),
          _buildDataRow(
            icon: Icons.schedule,
            title: loc.endTime,
            content: _formatDisplayTime(end),
            iconColor: _accentColor,
          ),
          _buildActionButtons(type: type, item: item),
        ],
      ),
    );
  }

  Widget _buildMergedRangeCard({
    required dynamic item,
    required String type,
    required IconData icon,
    required bool showDuration,
    required String startKey,
    required String endKey,
  }) {
    final start = item['start'] as DateTime?;
    final end = item['end'] as DateTime?;
    final sourceItems = (item['sourceItems'] as List<dynamic>? ?? []);

    if (start == null || end == null) return const SizedBox.shrink();

    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    return Card(
      color: Colors.grey.withOpacity(0.04),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        leading: Icon(icon, color: _accentColor),
        title: Text(
          '${_formatDisplayTime(start)} - ${_formatDisplayTime(end)}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: _textColor,
          ),
        ),
        subtitle: Text(
          sourceItems.length > 1
              ? _mergedFromText(sourceItems.length)
              : _singleRecordText,
          style: TextStyle(
            fontSize: 12,
            color: _textColor.withOpacity(0.65),
          ),
        ),
        children: [
          if (showDuration)
            _buildDataRow(
              icon: Icons.timer,
              title: loc.totalDuration,
              content: loc.durationHoursMinutes(hours, minutes),
              iconColor: _accentColor,
            ),
          ...sourceItems.map(
            (source) => _buildSourceRecordTile(
              type: type,
              item: source,
              startKey: startKey,
              endKey: endKey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntakeCard(dynamic item) {
    final time = _parseUserInputTime(item['taking_timestamp'] as String?);
    final amount = item['caffeine_amount']?.toString() ?? loc.notAvailable;
    final name = item['drink_name']?.toString() ?? loc.unknownDrink;

    if (time == null) return const SizedBox.shrink();

    return Card(
      color: Colors.grey.withOpacity(0.04),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildDataRow(
              icon: Icons.schedule,
              title: loc.intakeTime,
              content: _formatDisplayTime(time),
              iconColor: _accentColor,
            ),
            _buildDataRow(
              icon: Icons.spa,
              title: loc.contentLabel,
              content: loc.drinkWithAmount(name, amount),
              iconColor: _accentColor,
            ),
            _buildActionButtons(type: 'intake', item: item),
          ],
        ),
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
            style: TextStyle(
              fontSize: 14,
              color: _textColor.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy/MM/dd').format(widget.selectedDate);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: _backgroundColor,
          appBar: AppBar(
            title: Text(
              loc.userInputHistoryTitle(formattedDate),
              style: TextStyle(
                color: _primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: _primaryColor),
              onPressed: () => Navigator.pop(context),
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
                final userData = snapshot.data!;

                if (userData.isEmpty) {
                  return Center(
                    child: _buildEmptySection(
                      Icons.sentiment_dissatisfied,
                      loc.noUserInputOnThisDay,
                      loc.returnHomeAndAddRecord,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => _reloadPage(),
                  child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    children: [
                      _buildSectionTitle(
                        Icons.person_pin_outlined,
                        loc.yourInputHistory,
                      ),
                      _buildInputCard(
                        title: loc.actualSleepCycle,
                        icon: Icons.hotel_outlined,
                        dataList: userData.sleepCycles,
                        isEmptyMessage: loc.noActualSleepRecord,
                        buildItem: (item) => _buildMergedRangeCard(
                          item: item,
                          type: 'sleep',
                          icon: Icons.hotel_outlined,
                          showDuration: true,
                          startKey: 'sleep_start_time',
                          endKey: 'sleep_end_time',
                        ),
                      ),
                      _buildInputCard(
                        title: loc.targetWakePeriod,
                        icon: Icons.access_time_filled,
                        dataList: userData.wakePeriods,
                        isEmptyMessage: loc.noTargetWakePeriodRecord,
                        buildItem: (item) => _buildMergedRangeCard(
                          item: item,
                          type: 'wake',
                          icon: Icons.visibility_outlined,
                          showDuration: false,
                          startKey: 'target_start_time',
                          endKey: 'target_end_time',
                        ),
                      ),
                      _buildInputCard(
                        title: loc.caffeineIntake,
                        icon: Icons.local_cafe_outlined,
                        dataList: userData.caffeineIntakes,
                        isEmptyMessage: loc.noCaffeineIntakeRecord,
                        buildItem: (item) => _buildIntakeCard(item),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
        if (_isSubmitting)
          Container(
            color: Colors.black.withOpacity(0.15),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}