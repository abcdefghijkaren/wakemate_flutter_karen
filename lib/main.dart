import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:my_app/providers/locale_provider.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';

import '/screens/LoginPage.dart';
import '/screens/home_page.dart';

import 'package:my_app/services/notification_service.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

// ---------------------------
// FCM 設定
// ---------------------------
Future<void> setupFCM(String userId) async {
  try {
    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    final token = await messaging.getToken();

    print('FCM Token: $token');

    if (token != null) {
      final response = await http.post(
        Uri.parse('https://wakemate-api-4-0.onrender.com/users/fcm-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': int.parse(userId),
          'fcm_token': token,
        }),
      );

      print('FCM save response: ${response.statusCode}');
      print('FCM save body: ${response.body}');
    }
  } catch (e) {
    print('FCM setup error: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await NotificationService.instance.initialize();
  await NotificationService.instance.requestPermission();
  await NotificationService.instance.debugNotificationStatus();

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

// ---------------------------
// App 主體
// ---------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'WakeMate',
          theme: ThemeData(
            primaryColor: const Color(0xFF1F3D5B),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ).copyWith(
              secondary: const Color(0xFF5E91B3),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          locale: provider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AuthWrapper(),
        );
      },
    );
  }
}

// ---------------------------
// 登入狀態檢查
// ---------------------------
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  Future<Map<String, String?>>? _initialization;
  bool _fcmSetupDone = false;

  @override
  void initState() {
    super.initState();
    _initialization = _checkLoginStatus();
  }

  Future<Map<String, String?>> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn && userId != null && userId.isNotEmpty) {
      return {
        'userId': userId,
        'userName': prefs.getString('userName'),
        'userEmail': prefs.getString('userEmail'),
      };
    } else {
      return {'userId': null};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final userId = snapshot.data?['userId'];

        if (userId != null && userId.isNotEmpty) {
          final userName = snapshot.data?['userName'] ?? "";
          final userEmail = snapshot.data?['userEmail'] ?? "";

          if (!_fcmSetupDone) {
            _fcmSetupDone = true;
            setupFCM(userId);
          }

          return HomePage(
            userId: userId,
            userName: userName,
            email: userEmail,
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}