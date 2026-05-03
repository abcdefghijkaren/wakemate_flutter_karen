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

  static const String _testChannelId = 'test_reminder_channel';
  static const String _testChannelName = 'Alertness Test Reminder';
  static const String _testChannelDescription =
      'WakeMate alertness test reminders';

  late tz.Location _appLocation;
  bool _initialized = false;

  Future<void> initialize() async {
    debugPrint('[NOTI] initialize() called');

    tz.initializeTimeZones();
    _appLocation = tz.getLocation('Asia/Taipei');
    tz.setLocalLocation(_appLocation);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('[NOTI] notification tapped');
        debugPrint('[NOTI] payload = ${response.payload}');
      },
    );

    await _createChannels();

    _initialized = true;

    debugPrint('[NOTI] initialized successfully');
    debugPrint('[NOTI] tz.local = ${tz.local}');
    debugPrint('[NOTI] app location = $_appLocation');
  }

  Future<void> _createChannels() async {
    const caffeineChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.max,
    );

    const testChannel = AndroidNotificationChannel(
      _testChannelId,
      _testChannelName,
      description: _testChannelDescription,
      importance: Importance.max,
    );

    final androidImplementation =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.createNotificationChannel(caffeineChannel);
    await androidImplementation?.createNotificationChannel(testChannel);

    debugPrint('[NOTI] notification channels created');
  }

  Future<void> requestPermission() async {
    debugPrint('[NOTI] requestPermission() called');

    final androidImplementation =
        flutterLocalNotificationsPlugin
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

  NotificationDetails _caffeineNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  NotificationDetails _testNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _testChannelId,
        _testChannelName,
        channelDescription: _testChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showRecommendationReadyNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    _checkInitialized();

    debugPrint('[NOTI] showRecommendationReadyNotification()');
    debugPrint('[NOTI] id = $id');
    debugPrint('[NOTI] title = $title');
    debugPrint('[NOTI] body = $body');

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      _caffeineNotificationDetails(),
      payload: 'recommendation_ready',
    );
  }

  Future<void> scheduleCaffeineReminder({
    required int id,
    required DateTime scheduledTime,
    required String title,
    required String body,
    String? payload,
  }) async {
    _checkInitialized();

    final tzTime = tz.TZDateTime.from(scheduledTime, _appLocation);
    final nowTz = tz.TZDateTime.now(_appLocation);

    debugPrint('[NOTI] scheduleCaffeineReminder()');
    debugPrint('[NOTI] id = $id');
    debugPrint('[NOTI] scheduledTime = $scheduledTime');
    debugPrint('[NOTI] tzTime = $tzTime');
    debugPrint('[NOTI] nowTz = $nowTz');

    if (!tzTime.isAfter(nowTz)) {
      debugPrint('[NOTI] caffeine reminder skipped: time is past or now');
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      _caffeineNotificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload ?? 'caffeine_reminder',
    );

    debugPrint('[NOTI] caffeine reminder scheduled, id=$id');
  }

  Future<void> scheduleTestReminder({
    required int id,
    required DateTime scheduledTime,
    required String title,
    required String body,
    String? payload,
  }) async {
    _checkInitialized();

    final tzTime = tz.TZDateTime.from(scheduledTime, _appLocation);
    final nowTz = tz.TZDateTime.now(_appLocation);

    debugPrint('[NOTI] scheduleTestReminder()');
    debugPrint('[NOTI] id = $id');
    debugPrint('[NOTI] scheduledTime = $scheduledTime');
    debugPrint('[NOTI] tzTime = $tzTime');
    debugPrint('[NOTI] nowTz = $nowTz');

    if (!tzTime.isAfter(nowTz)) {
      debugPrint('[NOTI] test reminder skipped: time is past or now');
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      _testNotificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload ?? 'alertness_test_reminder',
    );

    debugPrint('[NOTI] test reminder scheduled, id=$id');
  }

  /// 核心功能：
  /// 計算完成後，一次安排：
  /// 1. 立即通知：推薦已產生
  /// 2. 推薦攝取時間通知
  /// 3. 攝取前清醒度測驗
  /// 4. 攝取後清醒度測驗
  Future<void> scheduleFullCaffeineNotificationSet({
    required int baseId,
    required DateTime recommendationTime,
    required int caffeineAmount,
    int preTestMinutesBefore = 10,
    int postTestMinutesAfter = 60,
  }) async {
    _checkInitialized();

    debugPrint('[NOTI] scheduleFullCaffeineNotificationSet() called');
    debugPrint('[NOTI] baseId = $baseId');
    debugPrint('[NOTI] recommendationTime = $recommendationTime');
    debugPrint('[NOTI] caffeineAmount = $caffeineAmount');
    debugPrint('[NOTI] preTestMinutesBefore = $preTestMinutesBefore');
    debugPrint('[NOTI] postTestMinutesAfter = $postTestMinutesAfter');

    final readyId = baseId;
    final caffeineId = baseId + 1;
    final preTestId = baseId + 2;
    final postTestId = baseId + 3;

    final preTestTime =
        recommendationTime.subtract(Duration(minutes: preTestMinutesBefore));
    final postTestTime =
        recommendationTime.add(Duration(minutes: postTestMinutesAfter));

    final timeText = _formatDateTime(recommendationTime);

    await showRecommendationReadyNotification(
      id: readyId,
      title: 'WakeMate 咖啡因建議已產生',
      body: '建議於 $timeText 攝取 $caffeineAmount mg 咖啡因。',
    );

    await scheduleCaffeineReminder(
      id: caffeineId,
      scheduledTime: recommendationTime,
      title: 'WakeMate 咖啡因提醒',
      body: '現在建議攝取 $caffeineAmount mg 咖啡因。',
      payload: 'caffeine_reminder_at_time',
    );

    await scheduleTestReminder(
      id: preTestId,
      scheduledTime: preTestTime,
      title: 'WakeMate 清醒度測驗',
      body: '請在攝取咖啡因前完成一次清醒度測驗。',
      payload: 'pre_caffeine_alertness_test',
    );

    await scheduleTestReminder(
      id: postTestId,
      scheduledTime: postTestTime,
      title: 'WakeMate 清醒度測驗',
      body: '你現在處於咖啡因作用期間，請完成一次清醒度測驗。',
      payload: 'post_caffeine_alertness_test',
    );

    await debugPendingNotifications();
  }

  Future<void> showImmediateTestReminder({
    required int id,
    required String title,
    required String body,
  }) async {
    _checkInitialized();

    debugPrint('[NOTI] showImmediateTestReminder() called');
    debugPrint('[NOTI] id = $id');
    debugPrint('[NOTI] title = $title');
    debugPrint('[NOTI] body = $body');

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      _testNotificationDetails(),
      payload: 'immediate_test_reminder',
    );

    debugPrint('[NOTI] immediate test reminder shown');
  }

  Future<void> showNowTestNotification() async {
    _checkInitialized();

    debugPrint('[NOTI] showNowTestNotification() called');

    await flutterLocalNotificationsPlugin.show(
      999001,
      'WakeMate 測試通知',
      '如果你看到這則通知，代表立即通知功能正常。',
      _caffeineNotificationDetails(),
      payload: 'show_now_test',
    );
  }

  Future<void> scheduleQuickCaffeineTest({
    int secondsLater = 30,
  }) async {
    final scheduledTime = DateTime.now().add(Duration(seconds: secondsLater));

    await scheduleCaffeineReminder(
      id: 999002,
      scheduledTime: scheduledTime,
      title: 'WakeMate 咖啡因測試通知',
      body: '$secondsLater 秒後的咖啡因提醒測試。',
      payload: 'quick_caffeine_test',
    );

    await debugPendingNotifications();
  }

  Future<void> scheduleQuickAlertnessTest({
    int secondsLater = 30,
  }) async {
    final scheduledTime = DateTime.now().add(Duration(seconds: secondsLater));

    await scheduleTestReminder(
      id: 999003,
      scheduledTime: scheduledTime,
      title: 'WakeMate 清醒度測驗測試',
      body: '$secondsLater 秒後的清醒度測驗提醒測試。',
      payload: 'quick_alertness_test',
    );

    await debugPendingNotifications();
  }

  Future<void> debugPendingNotifications() async {
    _checkInitialized();

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
    _checkInitialized();

    final androidImplementation =
        flutterLocalNotificationsPlugin
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
    _checkInitialized();

    debugPrint('[NOTI] cancel id = $id');
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAll() async {
    _checkInitialized();

    debugPrint('[NOTI] cancelAll()');
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelRecommendationNotifications() async {
    _checkInitialized();

    debugPrint('[NOTI] cancelRecommendationNotifications()');

    for (int i = 0; i < 200; i++) {
      await flutterLocalNotificationsPlugin.cancel(100000 + i);
      await flutterLocalNotificationsPlugin.cancel(200000 + i);
    }
  }

  Future<void> cancelTestNotifications() async {
    _checkInitialized();

    debugPrint('[NOTI] cancelTestNotifications()');

    for (int i = 0; i < 200; i++) {
      await flutterLocalNotificationsPlugin.cancel(300000 + i);
      await flutterLocalNotificationsPlugin.cancel(400000 + i);
      await flutterLocalNotificationsPlugin.cancel(500000 + i);
    }
  }

  String _formatDateTime(DateTime time) {
    return '${time.month}/${time.day} '
        '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Exception(
        'NotificationService 尚未初始化，請先在 main() 呼叫 initialize()',
      );
    }
  }
}