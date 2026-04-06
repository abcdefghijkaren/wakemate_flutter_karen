import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';
import 'CaffeineHistory.dart';

import 'package:my_app/services/notification_service.dart';

class CaffeineRecommendationPage extends StatefulWidget {
  final String userId;
  final DateTime selectedDate;

  const CaffeineRecommendationPage({
    super.key,
    required this.userId,
    required this.selectedDate,
  });

  @override
  State<CaffeineRecommendationPage> createState() =>
      _CaffeineRecommendationPageState();
}

class _CaffeineRecommendationPageState extends State<CaffeineRecommendationPage>
    with SingleTickerProviderStateMixin {
  final Color _primaryColor = const Color(0xFF1F3D5B);
  final Color _accentColor = const Color(0xFF5E91B3);

  bool _isLoading = true;
  String _errorMessage = "";

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      sendAllDataAndFetchRecommendation();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {Color color = Colors.red}) {
    if (!mounted) return;
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

  DateTime? _parseAndLocalize(String? datetimeStr) {
    if (datetimeStr == null || datetimeStr.isEmpty) return null;
    try {
      return DateTime.parse(datetimeStr).toLocal();
    } catch (e) {
      print('Time parsing failed for "$datetimeStr". Error: $e');
      return null;
    }
  }

  String _selectedDisplayDate() {
    return DateFormat('yyyy-MM-dd').format(widget.selectedDate);
  }

  bool _isSameSelectedDate(DateTime dateTime) {
    final selectedDateStr = _selectedDisplayDate();
    final itemDateStr = DateFormat('yyyy-MM-dd').format(dateTime);
    return selectedDateStr == itemDateStr;
  }

  String _getDisplayStatus(dynamic item) {
    final bool isActive = item['is_active'] ?? true;
    final String? timingStr = item['recommended_caffeine_intake_timing'];

    final localTime = _parseAndLocalize(timingStr);
    if (localTime == null) return 'unknown';

    if (!isActive) return 'expired';
    if (localTime.isBefore(DateTime.now())) return 'expired';

    return 'active';
  }

  bool _shouldStoreRecommendation(dynamic item) {
    final String timingStr = item['recommended_caffeine_intake_timing'] ?? '';
    if (timingStr.isEmpty) return false;

    final DateTime? localDateTime = _parseAndLocalize(timingStr);
    if (localDateTime == null) return false;

    // ⭐ 保留邏輯放寬：
    // 只要是本次 API 回傳的資料都可以存，但真正顯示歸屬由 display_date 決定。
    // 為避免把非常舊的歷史推薦整批塞進來，仍限制只保留與 selectedDate 接近的資料：
    // 這裡接受 selectedDate 當天，或 selectedDate 隔天凌晨跨日的推薦。
    final selectedDateStart = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
    );
    final nextDayEnd = selectedDateStart.add(const Duration(days: 2));

    return !localDateTime.isBefore(selectedDateStart) &&
        localDateTime.isBefore(nextDayEnd);
  }

  bool _shouldNotifyRecommendation(dynamic item) {
    final String status = _getDisplayStatus(item);
    if (status != 'active') return false;

    final String timingStr = item['recommended_caffeine_intake_timing'] ?? '';
    final DateTime? localDateTime = _parseAndLocalize(timingStr);
    if (localDateTime == null) return false;

    // 通知仍依實際推薦時間是否屬於這次 selectedDate 的需求範圍來發送。
    // 這裡同樣放寬到 selectedDate 起算 48 小時內，避免跨午夜推薦不通知。
    final selectedDateStart = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
    );
    final nextDayEnd = selectedDateStart.add(const Duration(days: 2));

    return !localDateTime.isBefore(selectedDateStart) &&
        localDateTime.isBefore(nextDayEnd);
  }

  Future<void> _saveRecommendationData(dynamic newData) async {
    final prefs = await SharedPreferences.getInstance();
    final dataStr = prefs.getString('caffeine_recommendations') ?? '[]';
    List<dynamic> currentHistory;

    try {
      currentHistory = json.decode(dataStr);
    } catch (e) {
      print('Error decoding existing history: $e. Starting with empty list.');
      currentHistory = [];
    }

    final List<dynamic> newEntries = newData is List ? newData : [newData];
    final String displayDate = _selectedDisplayDate();
    final nowIso = DateTime.now().toIso8601String();

    // ⭐ 清除同一 display_date 的舊資料，而不是用推薦時間日期清除
    currentHistory = currentHistory.where((item) {
      final String? itemDisplayDate = item['display_date']?.toString();
      if (itemDisplayDate != null && itemDisplayDate.isNotEmpty) {
        return itemDisplayDate != displayDate;
      }

      // 舊版資料沒有 display_date 時，退回舊判斷
      final String timingStr = item['recommended_caffeine_intake_timing'] ?? '';
      if (timingStr.isEmpty) return true;

      final DateTime? localDateTime = _parseAndLocalize(timingStr);
      if (localDateTime == null) return true;

      return !_isSameSelectedDate(localDateTime);
    }).toList();

    final normalizedEntries = newEntries
        .where((item) => _shouldStoreRecommendation(item))
        .map((item) {
          final map = Map<String, dynamic>.from(item);
          map['display_status'] = _getDisplayStatus(item);
          map['fetched_at'] = nowIso;
          map['display_date'] = displayDate; // ⭐ 新增：顯示歸屬日
          return map;
        })
        .toList();

    currentHistory.addAll(normalizedEntries);

    await prefs.setString(
      'caffeine_recommendations',
      json.encode(currentHistory),
    );

    print('✅ 已更新推薦資料，共 ${currentHistory.length} 筆');
  }

  Future<void> sendAllDataAndFetchRecommendation() async {
    final loc = AppLocalizations.of(context)!;
    final userId = widget.userId;

    try {
      const timeout = Duration(seconds: 15);

      final recommendationUrl =
          "https://wakemate-api-4-0.onrender.com/recommendations/?user_id=$userId";

      final recommendationResponse = await http
          .get(Uri.parse(recommendationUrl))
          .timeout(timeout);

      final status = recommendationResponse.statusCode;
      final rawBody = recommendationResponse.body;

      print('📡 recommendation status = $status');
      print('📡 recommendation body = $rawBody');

      if (status == 200) {
        dynamic data;

        try {
          data = rawBody.trim().isEmpty ? [] : json.decode(rawBody);
        } catch (e) {
          _showSnackBar(loc.recommendationDataFormatError, color: Colors.red);
          if (mounted) {
            setState(() {
              _errorMessage =
                  loc.recommendationParseFailed(e.toString(), rawBody);
              _isLoading = false;
            });
            _animationController.reverse();
          }
          return;
        }

        final List<dynamic> items = data is List ? data : [data];

        await _saveRecommendationData(items);

        try {
          await _scheduleNotificationsFromRecommendation(items);
        } catch (e) {
          print('⚠️ 通知排程失敗，但推薦計算成功：$e');
          _showSnackBar(
            loc.recommendationUpdatedButNotificationFailed,
            color: Colors.orange,
          );
        }

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CaffeineHistoryPage(
              userId: widget.userId,
              selectedDate: widget.selectedDate,
            ),
          ),
        );
        return;
      }

      if (status == 204 || status == 404) {
        _showSnackBar(loc.noNewRecommendationData, color: Colors.orange);

        if (mounted) {
          setState(() {
            _errorMessage = loc.noNewRecommendationDataMessage;
            _isLoading = false;
          });
          _animationController.reverse();
        }
        return;
      }

      String bodyPreview =
          rawBody.length > 100 ? '${rawBody.substring(0, 100)}...' : rawBody;

      _showSnackBar(loc.calculationFailedWithStatus(status), color: Colors.red);
      if (mounted) {
        setState(() {
          _errorMessage = loc.serverErrorWithPreview(status, bodyPreview);
          _isLoading = false;
        });
        _animationController.reverse();
      }
    } on TimeoutException {
      _showSnackBar(loc.timeoutCheckNetwork, color: Colors.red);
      if (mounted) {
        setState(() {
          _errorMessage = loc.connectionTimedOut;
          _isLoading = false;
        });
        _animationController.reverse();
      }
    } on SocketException {
      _showSnackBar(loc.networkConnectionError, color: Colors.red);
      if (mounted) {
        setState(() {
          _errorMessage = loc.cannotConnectToServer;
          _isLoading = false;
        });
        _animationController.reverse();
      }
    } catch (e) {
      _showSnackBar(loc.unknownError(e.toString()), color: Colors.red);
      if (mounted) {
        setState(() {
          _errorMessage = loc.unknownError(e.toString());
          _isLoading = false;
        });
        _animationController.reverse();
      }
    }
  }

  Future<void> _scheduleNotificationsFromRecommendation(dynamic data) async {
    final loc = AppLocalizations.of(context)!;

    await NotificationService.instance.cancelRecommendationNotifications();

    final List<dynamic> items = data is List ? data : [data];
    int validIndex = 0;

    for (final item in items) {
      if (!_shouldNotifyRecommendation(item)) {
        continue;
      }

      final String timingStr = item['recommended_caffeine_intake_timing'];
      final dynamic amount = item['recommended_caffeine_amount'];

      final num caffeineAmount =
          amount is num ? amount : num.tryParse(amount.toString()) ?? 0;

      if (caffeineAmount <= 0) continue;

      final DateTime? scheduledLocal = _parseAndLocalize(timingStr);
      if (scheduledLocal == null) continue;

      final String formattedTime =
          '${scheduledLocal.hour.toString().padLeft(2, '0')}:'
          '${scheduledLocal.minute.toString().padLeft(2, '0')}';

      final String formattedAmount =
          caffeineAmount.toStringAsFixed(caffeineAmount % 1 == 0 ? 0 : 1);

      // 第一次：計算完成當下立即通知
      await NotificationService.instance.showRecommendationReadyNotification(
        id: 100000 + validIndex,
        title: loc.wakemateRecommendationGenerated,
        body: loc.recommendationGeneratedBody(formattedTime, formattedAmount),
      );

      // 第二次：在「推薦時間」發送通知
      if (scheduledLocal.isAfter(DateTime.now())) {
        await NotificationService.instance.scheduleCaffeineReminder(
          id: 200000 + validIndex,
          scheduledTime: scheduledLocal,
          title: loc.wakemateCaffeineReminder,
          body: loc.caffeineReminderBody(formattedTime, formattedAmount),
          payload: 'caffeine_reminder_at_time',
        );
      } else {
        print(
          '⚠️ 已略過定時通知：推薦時間已過 scheduledLocal=$scheduledLocal, now=${DateTime.now()}',
        );
      }

      validIndex++;
    }

    await NotificationService.instance.debugPendingNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          loc.caffeineRecommendationPageTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(color: Colors.white),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _animationController.value * 5,
                    sigmaY: _animationController.value * 5,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(
                      0.1 * _animationController.value,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: _isLoading
                                ? _buildLoadingWidget()
                                : _buildErrorWidget(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    final loc = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: _primaryColor, strokeWidth: 5),
        const SizedBox(height: 24),
        Text(
          loc.analyzingCaffeineData,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          loc.thisMayTakeSomeTimePleaseWait,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    final loc = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent, size: 70),
        const SizedBox(height: 20),
        Text(
          loc.oopsCalculationFailed,
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[700], fontSize: 15),
        ),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          onPressed: () {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _errorMessage = "";
              });
              _animationController.reset();
              _animationController.forward();
              sendAllDataAndFetchRecommendation();
            }
          },
          icon: const Icon(Icons.refresh, size: 20),
          label: Text(loc.retry, style: const TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
          ),
        ),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            loc.backToHomePage,
            style: TextStyle(color: _accentColor, fontSize: 16),
          ),
        ),
      ],
    );
  }
}