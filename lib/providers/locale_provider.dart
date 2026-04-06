import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('zh', 'TW');

  Locale get locale => _locale;

  String get localeCode => localeToCode(_locale);

  LocaleProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String code = prefs.getString('appLanguage') ?? 'zh_TW';

    _locale = _codeToLocale(code);
    notifyListeners();
  }

  Future<void> setLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLanguage', code);

    _locale = _codeToLocale(code);
    notifyListeners();
  }

  Locale _codeToLocale(String code) {
    switch (code) {
      case 'en':
        return const Locale('en');
      case 'id':
        return const Locale('id');
      case 'zh_TW':
        return const Locale('zh', 'TW');
      case 'zh':
        return const Locale('zh');
      default:
        return const Locale('zh', 'TW');
    }
  }

  String localeToCode(Locale locale) {
    final lang = locale.languageCode;
    final country = locale.countryCode;

    if (lang == 'zh' && country == 'TW') return 'zh_TW';
    if (lang == 'zh') return 'zh';
    if (lang == 'en') return 'en';
    if (lang == 'id') return 'id';

    return 'zh_TW';
  }
}