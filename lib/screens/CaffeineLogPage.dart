import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';

class CaffeineLogPage extends StatefulWidget {
  final String userId;
  final DateTime selectedDate;

  const CaffeineLogPage({
    super.key,
    required this.userId,
    required this.selectedDate,
  });

  @override
  State<CaffeineLogPage> createState() => _CaffeineLogPageState();
}

class _CaffeineLogPageState extends State<CaffeineLogPage> {
  final TextEditingController caffeineController = TextEditingController();
  final TextEditingController drinkNameController = TextEditingController();
  final TextEditingController takingTimeController = TextEditingController();

  final String baseUrl = 'https://wakemate-api-4-0.onrender.com';

  final Color _primaryColor = const Color(0xFF4B6B7A);
  final Color _accentColor = const Color(0xFF8BB9A1);
  final Color _bgLight = const Color(0xFFF9F9F7);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      drinkNameController.text = AppLocalizations.of(context)!.defaultDrink;
    });

    final initialTime = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      DateTime.now().hour,
      DateTime.now().minute,
    );

    takingTimeController.text =
        DateFormat('yyyy-MM-dd HH:mm').format(initialTime);
  }

  @override
  void dispose() {
    caffeineController.dispose();
    drinkNameController.dispose();
    takingTimeController.dispose();
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
      final dt = DateFormat('yyyy-MM-dd HH:mm').parse(time);
      return dt.toIso8601String();
    } catch (e) {
      return DateTime.now().toIso8601String();
    }
  }

  Future<void> _saveToLocal(
    double caffeineAmount,
    String takingTimeString,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final DateTime takingDateTime =
        DateFormat('yyyy-MM-dd HH:mm').parse(takingTimeString);

    final String dateKey = DateFormat('yyyy-MM-dd').format(takingDateTime);
    final String prefsKey = 'caffeine_$dateKey';

    double currentTotal = prefs.getDouble(prefsKey) ?? 0;
    double newTotal = currentTotal + caffeineAmount;

    await prefs.setDouble(prefsKey, newTotal);
  }

  Future<void> _submitData() async {
    final loc = AppLocalizations.of(context)!;

    final uuid = widget.userId;
    final caffeine = caffeineController.text.trim();
    final drinkName = drinkNameController.text.trim();
    final takingTime = takingTimeController.text.trim();

    if (caffeine.isEmpty || drinkName.isEmpty || takingTime.isEmpty) {
      _showSnackBar(loc.fillAllFields);
      return;
    }

    final int? caffeineAmount = int.tryParse(caffeine);
    if (caffeineAmount == null || caffeineAmount <= 0) {
      _showSnackBar(loc.invalidCaffeine);
      return;
    }

    try {
      final res = await http.post(
        Uri.parse('$baseUrl/users_intake/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': uuid,
          'caffeine_amount': caffeineAmount,
          'drink_name': drinkName,
          'taking_timestamp': formatToISO8601(takingTime),
        }),
      );

      if (res.statusCode == 200) {
        await _saveToLocal(caffeineAmount.toDouble(), takingTime);

        _showSnackBar(
          loc.saveSuccess,
          color: _accentColor,
        );

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        _showSnackBar(loc.saveFailed);
      }
    } catch (e) {
      _showSnackBar(loc.errorOccurred(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        title: Text(
          loc.addCaffeineLog,
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
              loc.caffeineDescription,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: caffeineController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: loc.caffeineAmount,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: loc.caffeineExample,
                prefixIcon: Icon(
                  Icons.local_cafe_outlined,
                  color: _primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: drinkNameController,
              decoration: InputDecoration(
                labelText: loc.drinkName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: loc.drinkExample,
                prefixIcon: Icon(
                  Icons.local_drink_outlined,
                  color: _primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: takingTimeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: loc.takingTime,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(
                  Icons.access_time_rounded,
                  color: _primaryColor,
                ),
              ),
              onTap: () => _pickDateTime(takingTimeController),
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
                  loc.saveCaffeineLog,
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