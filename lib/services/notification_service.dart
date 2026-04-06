import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'caffeine_reminder_channel';
  static const String _channelName = 'WAKEMATE Reminder';
  static const String _channelDescription =
      'WAKEMATE caffeine recommendation reminder';

  static final tz.Location _appLocation = tz.getLocation('Asia/Taipei');

  Future<void> initialize() async {
    debugPrint('[NOTI] initialize() called');

    tz.initializeTimeZones();
    tz.setLocalLocation(_appLocation);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('[NOTI] notification tapped, payload=${response.payload}');
      },
    );

    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    debugPrint('[NOTI] timezone initialized');
    debugPrint('[NOTI] tz.local = ${tz.local}');
    debugPrint('[NOTI] notification channel created: $_channelId');
  }

  Future<void> requestPermission() async {
    debugPrint('[NOTI] requestPermission() called');

    final androidImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? notificationGranted =
        await androidImplementation?.requestNotificationsPermission();
    debugPrint('[NOTI] notification permission result = $notificationGranted');

    final bool? notificationsEnabled =
        await androidImplementation?.areNotificationsEnabled();
    debugPrint('[NOTI] areNotificationsEnabled = $notificationsEnabled');

    final bool? canScheduleExact =
        await androidImplementation?.canScheduleExactNotifications();
    debugPrint('[NOTI] canScheduleExactNotifications = $canScheduleExact');

    if (canScheduleExact == false) {
      final bool? exactGranted =
          await androidImplementation?.requestExactAlarmsPermission();
      debugPrint('[NOTI] requestExactAlarmsPermission result = $exactGranted');
    }

    final bool? canScheduleExactAfterRequest =
        await androidImplementation?.canScheduleExactNotifications();
    debugPrint(
      '[NOTI] canScheduleExactNotifications(after request) = $canScheduleExactAfterRequest',
    );
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showRecommendationReadyNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    debugPrint('[NOTI] showRecommendationReadyNotification() called');

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      _notificationDetails(),
      payload: 'recommendation_ready',
    );

    debugPrint('[NOTI] recommendation ready notification sent');
  }

  Future<void> scheduleCaffeineReminder({
    required int id,
    required DateTime scheduledTime,
    required String title,
    required String body,
    String? payload,
  }) async {
    final tz.TZDateTime tzTime =
        tz.TZDateTime.from(scheduledTime, _appLocation);
    final tz.TZDateTime nowTz = tz.TZDateTime.now(_appLocation);

    debugPrint('[NOTI] scheduleCaffeineReminder() called');
    debugPrint('[NOTI] id = $id');
    debugPrint('[NOTI] title = $title');
    debugPrint('[NOTI] body = $body');
    debugPrint('[NOTI] scheduledTime(local DateTime) = $scheduledTime');
    debugPrint('[NOTI] scheduledTime(tz) = $tzTime');
    debugPrint('[NOTI] now(local DateTime) = ${DateTime.now()}');
    debugPrint('[NOTI] now(tz) = $nowTz');

    if (!tzTime.isAfter(nowTz)) {
      debugPrint('[NOTI] skipped: scheduled time is in the past or now');
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );

    debugPrint('[NOTI] scheduled successfully, id=$id');
  }

  /// 計算完成時立刻發一次，並在推薦時間再發一次通知
  Future<void> sendReadyAndScheduleReminder({
    required int readyNotificationId,
    required int reminderNotificationId,
    required DateTime recommendationTime,
    required String readyTitle,
    required String readyBody,
    required String reminderTitle,
    required String reminderBody,
  }) async {
    debugPrint('[NOTI] sendReadyAndScheduleReminder() called');
    debugPrint('[NOTI] recommendationTime = $recommendationTime');

    // 1) 當下立即通知
    await showRecommendationReadyNotification(
      id: readyNotificationId,
      title: readyTitle,
      body: readyBody,
    );

    // 2) 在推薦時間排程通知
    final now = DateTime.now();

    debugPrint('[NOTI] now = $now');
    debugPrint('[NOTI] scheduled recommendationTime = $recommendationTime');

    if (recommendationTime.isAfter(now)) {
      await scheduleCaffeineReminder(
        id: reminderNotificationId,
        scheduledTime: recommendationTime,
        title: reminderTitle,
        body: reminderBody,
        payload: 'caffeine_reminder_at_time',
      );
    } else {
      debugPrint(
        '[NOTI] recommendation-time reminder skipped because recommendationTime is already past',
      );
    }

    await debugPendingNotifications();
  }

  Future<void> scheduleQuickTest({
    int secondsLater = 30,
  }) async {
    final scheduledTime = DateTime.now().add(Duration(seconds: secondsLater));

    debugPrint('[NOTI] scheduleQuickTest() called');
    debugPrint('[NOTI] now = ${DateTime.now()}');
    debugPrint('[NOTI] scheduledTime = $scheduledTime');

    await scheduleCaffeineReminder(
      id: 999002,
      scheduledTime: scheduledTime,
      title: 'WAKEMATE Quick Test',
      body: 'This is a test notification after $secondsLater seconds',
      payload: 'quick_test',
    );

    await debugPendingNotifications();
  }

  Future<void> debugPendingNotifications() async {
    final pending =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    debugPrint('[NOTI] ===== Pending notifications: ${pending.length} =====');
    for (final item in pending) {
      debugPrint(
        '[NOTI] pending -> id=${item.id}, title=${item.title}, body=${item.body}, payload=${item.payload}',
      );
    }
  }

  Future<void> debugNotificationStatus() async {
    final androidImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? enabled = await androidImplementation?.areNotificationsEnabled();
    final bool? canScheduleExact =
        await androidImplementation?.canScheduleExactNotifications();

    debugPrint('[NOTI] ===== Notification status =====');
    debugPrint('[NOTI] notifications enabled = $enabled');
    debugPrint('[NOTI] canScheduleExactNotifications = $canScheduleExact');
    debugPrint('[NOTI] current local time = ${DateTime.now()}');
    debugPrint('[NOTI] tz.local = ${tz.local}');
    debugPrint('[NOTI] app location = $_appLocation');
  }

  Future<void> cancel(int id) async {
    debugPrint('[NOTI] cancel(id=$id)');
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAll() async {
    debugPrint('[NOTI] cancelAll()');
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelRecommendationNotifications() async {
    debugPrint('[NOTI] cancelRecommendationNotifications()');

    for (int i = 0; i < 100; i++) {
      await flutterLocalNotificationsPlugin.cancel(100000 + i);
      await flutterLocalNotificationsPlugin.cancel(200000 + i);
    }
  }
}