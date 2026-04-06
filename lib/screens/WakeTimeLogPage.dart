import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';

const String _kTargetWakePeriodsKey = 'target_wake_periods_list_json';

class TimeSlot {
  final Key key = UniqueKey();
  TextEditingController startController;
  TextEditingController endController;

  TimeSlot({String? startTime, String? endTime})
      : startController = TextEditingController(text: startTime),
        endController = TextEditingController(text: endTime);

  Map<String, String> toJson() => {
        'start': startController.text,
        'end': endController.text,
      };

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['start'] as String?,
      endTime: json['end'] as String?,
    );
  }
}

class TargetWakeTimePage extends StatefulWidget {
  final String userId;
  final DateTime selectedDate;

  const TargetWakeTimePage({
    super.key,
    required this.userId,
    required this.selectedDate,
  });

  @override
  State<TargetWakeTimePage> createState() => _TargetWakeTimePageState();
}

class _TargetWakeTimePageState extends State<TargetWakeTimePage> {
  final Color _primaryColor = const Color(0xFF4B6B7A);
  final Color _accentColor = const Color(0xFF8BB9A1);
  final Color _bgLight = const Color(0xFFF9F9F7);

  final String baseUrl = 'https://wakemate-api-4-0.onrender.com';

  final List<TimeSlot> _timeSlots = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPeriods();
  }

  void _loadSavedPeriods() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_kTargetWakePeriodsKey);

    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        setState(() {
          _timeSlots.addAll(jsonList.map((j) => TimeSlot.fromJson(j)));
        });
      } catch (e) {}
    }

    if (_timeSlots.isEmpty) {
      _addTimeSlot();
    }
  }

  void _addTimeSlot() {
    final now = widget.selectedDate;
    final defaultStart = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(DateTime(now.year, now.month, now.day, 9, 0));
    final defaultEnd = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(DateTime(now.year, now.month, now.day, 10, 0));

    setState(() {
      _timeSlots.add(TimeSlot(startTime: defaultStart, endTime: defaultEnd));
    });
  }

  void _removeTimeSlot(Key key) {
    setState(() {
      _timeSlots.removeWhere((slot) => slot.key == key);
      if (_timeSlots.isEmpty) {
        _addTimeSlot();
      }
    });
  }

  String _formatToISO8601(String time) {
    try {
      final dt = DateFormat('yyyy-MM-dd HH:mm').parse(time, true);
      return dt.toIso8601String();
    } catch (e) {
      return DateTime.now().toIso8601String();
    }
  }

  Future<void> _saveData() async {
    final loc = AppLocalizations.of(context)!;

    if (_timeSlots.any(
      (slot) =>
          slot.startController.text.isEmpty || slot.endController.text.isEmpty,
    )) {
      _showSnackBar(loc.wakeFillAllTimeSlots);
      return;
    }

    try {
      for (var slot in _timeSlots) {
        final dtStart = DateFormat(
          'yyyy-MM-dd HH:mm',
        ).parse(slot.startController.text);
        final dtEnd = DateFormat(
          'yyyy-MM-dd HH:mm',
        ).parse(slot.endController.text);

        if (dtEnd.isBefore(dtStart)) {
          _showSnackBar(loc.wakeEndBeforeStart);
          return;
        }
      }
    } catch (e) {
      _showSnackBar(loc.wakeInvalidTimeFormat);
      return;
    }

    final headers = {'Content-Type': 'application/json'};
    int successfulSubmissions = 0;

    try {
      for (var slot in _timeSlots) {
        final payload = {
          'user_id': widget.userId,
          'target_start_time': _formatToISO8601(slot.startController.text),
          'target_end_time': _formatToISO8601(slot.endController.text),
        };

        final res = await http.post(
          Uri.parse('$baseUrl/users_wake/'),
          headers: headers,
          body: jsonEncode(payload),
        );

        if (res.statusCode == 200) {
          successfulSubmissions++;
        } else {
          _showSnackBar(
            loc.wakeSingleSlotFailed(
              _timeSlots.indexOf(slot) + 1,
              res.statusCode,
            ),
            color: Colors.orange,
          );
        }
      }

      if (successfulSubmissions == _timeSlots.length) {
        final jsonList = _timeSlots.map((slot) => slot.toJson()).toList();
        final jsonString = json.encode(jsonList);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_kTargetWakePeriodsKey, jsonString);

        _showSnackBar(
          loc.wakeSaveAllSuccess(_timeSlots.length),
          color: _accentColor,
        );

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else if (successfulSubmissions > 0) {
        _showSnackBar(
          loc.wakePartialSuccess(
            successfulSubmissions,
            _timeSlots.length - successfulSubmissions,
          ),
          color: Colors.orange,
        );
      } else {
        _showSnackBar(loc.wakeAllFailed);
      }
    } catch (e) {
      _showSnackBar(loc.errorOccurred(e.toString()));
    }
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

  Widget _buildTimeSlot(TimeSlot slot) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      key: slot.key,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.wakeSlotTitle(_timeSlots.indexOf(slot) + 1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              if (_timeSlots.length > 1)
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => _removeTimeSlot(slot.key),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              TextField(
                controller: slot.startController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: loc.startTime,
                  hintText: loc.timeExampleStart,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(
                    Icons.access_time,
                    color: _primaryColor,
                  ),
                ),
                onTap: () => _pickDateTime(slot.startController),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: slot.endController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: loc.endTime,
                  hintText: loc.timeExampleEnd,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(
                    Icons.access_time_filled,
                    color: _primaryColor,
                  ),
                ),
                onTap: () => _pickDateTime(slot.endController),
              ),
            ],
          ),
          const Divider(height: 25, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        title: Text(
          loc.wakePageTitle,
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
              loc.wakeDescription,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ..._timeSlots.map(_buildTimeSlot).toList(),
            OutlinedButton.icon(
              onPressed: _addTimeSlot,
              style: OutlinedButton.styleFrom(
                foregroundColor: _accentColor,
                side: BorderSide(color: _accentColor, width: 2),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add),
              label: Text(
                loc.addTimeSlot,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                icon: const Icon(Icons.cloud_upload),
                label: Text(
                  loc.saveWakeTime,
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