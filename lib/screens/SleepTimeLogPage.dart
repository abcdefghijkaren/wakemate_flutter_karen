import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';

class ActualSleepTimePage extends StatefulWidget {
  final String userId;
  final DateTime selectedDate;

  const ActualSleepTimePage({
    super.key,
    required this.userId,
    required this.selectedDate,
  });

  @override
  State<ActualSleepTimePage> createState() => _ActualSleepTimePageState();
}

class _ActualSleepTimePageState extends State<ActualSleepTimePage> {
  final TextEditingController sleepStartController = TextEditingController();
  final TextEditingController sleepEndController = TextEditingController();

  final String baseUrl = 'https://wakemate-api-4-0.onrender.com';

  final Color _primaryColor = const Color(0xFF4B6B7A);
  final Color _accentColor = const Color(0xFF8BB9A1);
  final Color _bgLight = const Color(0xFFF9F9F7);

  @override
  void initState() {
    super.initState();
    _loadInitialTimes();
  }

  void _loadInitialTimes() {
    final now = widget.selectedDate;

    sleepStartController.text = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(DateTime(now.year, now.month, now.day - 1, 23, 0));

    sleepEndController.text = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(DateTime(now.year, now.month, now.day, 7, 0));
  }

  @override
  void dispose() {
    sleepStartController.dispose();
    sleepEndController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {Color color = Colors.red}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _pickDateTime(TextEditingController controller) async {
    DateTime initialDateTime;
    try {
      initialDateTime = DateFormat('yyyy-MM-dd HH:mm').parse(controller.text);
    } catch (e) {
      initialDateTime = DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime),
    );
    if (pickedTime == null) return;

    DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    controller.text = DateFormat('yyyy-MM-dd HH:mm').format(finalDateTime);
  }

  String formatToISO8601(String time) {
    try {
      final dt = DateFormat('yyyy-MM-dd HH:mm').parse(time, true);
      return dt.toIso8601String();
    } catch (e) {
      return DateTime.now().toIso8601String();
    }
  }

  Future<void> _submitData() async {
    final loc = AppLocalizations.of(context)!;

    final uuid = widget.userId;
    final sleepStartTimeText = sleepStartController.text.trim();
    final sleepEndTimeText = sleepEndController.text.trim();

    if (sleepStartTimeText.isEmpty || sleepEndTimeText.isEmpty) {
      _showSnackBar(loc.sleepPleaseSelectStartAndEndTime);
      return;
    }

    late DateTime dtStart, dtEnd;
    try {
      dtStart = DateFormat('yyyy-MM-dd HH:mm').parse(sleepStartTimeText);
      dtEnd = DateFormat('yyyy-MM-dd HH:mm').parse(sleepEndTimeText);

      if (dtEnd.isBefore(dtStart)) {
        _showSnackBar(
          loc.sleepEndCannotBeEarlierThanStart,
          color: Colors.red,
        );
        return;
      }

      if (dtEnd.difference(dtStart).inDays > 2) {
        _showSnackBar(
          loc.sleepTooLongOver48Hours,
          color: Colors.red,
        );
        return;
      }
    } catch (e) {
      _showSnackBar(
        loc.sleepInvalidTimeFormat,
        color: Colors.red,
      );
      return;
    }

    final sleepStartTimeISO = formatToISO8601(sleepStartTimeText);
    final sleepEndTimeISO = formatToISO8601(sleepEndTimeText);

    final headers = {'Content-Type': 'application/json'};

    try {
      final sleepRes = await http.post(
        Uri.parse('$baseUrl/users_sleep/'),
        headers: headers,
        body: jsonEncode({
          'user_id': uuid,
          'sleep_start_time': sleepStartTimeISO,
          'sleep_end_time': sleepEndTimeISO,
        }),
      );

      if (sleepRes.statusCode == 200) {
        await _handleSuccessfulSave(dtStart, dtEnd);

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        String sleepBody =
            sleepRes.body.isNotEmpty ? sleepRes.body : loc.noResponseContent;
        _showSnackBar(
          loc.sleepSaveFailedWithReason(sleepRes.statusCode, sleepBody),
        );
      }
    } catch (e) {
      _showSnackBar(loc.errorOccurred(e.toString()));
    }
  }

  Future<void> _handleSuccessfulSave(DateTime dtStart, DateTime dtEnd) async {
    final loc = AppLocalizations.of(context)!;

    try {
      final duration = dtEnd.difference(dtStart);

      final double totalHours = duration.inMinutes / 60.0;

      final prefs = await SharedPreferences.getInstance();

      final String dateKey = DateFormat('yyyy-MM-dd').format(dtEnd);
      final String prefsKey = 'sleep_$dateKey';

      await prefs.setDouble(prefsKey, totalHours);
      print('[$prefsKey] saved successfully: $totalHours hours');

      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      _showSnackBar(
        loc.sleepSaveSuccessWithDuration(hours, minutes),
        color: _accentColor,
      );
    } catch (e) {
      _showSnackBar(
        loc.sleepDurationCalculationFailed,
        color: Colors.orange,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        title: Text(
          loc.addActualSleepTime,
          style: TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 1,
        shadowColor: Colors.black12,
        iconTheme: IconThemeData(color: _primaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              loc.actualSleepTimeDescription,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            TextField(
              controller: sleepStartController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: loc.sleepStartTimePick,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(
                  Icons.hotel_outlined,
                  color: _primaryColor,
                ),
                hintText: loc.sleepStartExample,
              ),
              onTap: () => _pickDateTime(sleepStartController),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: sleepEndController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: loc.sleepEndTimePick,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(
                  Icons.access_time_rounded,
                  color: _primaryColor,
                ),
                hintText: loc.sleepEndExample,
              ),
              onTap: () => _pickDateTime(sleepEndController),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                icon: const Icon(Icons.save),
                label: Text(
                  loc.saveSleepCycle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}