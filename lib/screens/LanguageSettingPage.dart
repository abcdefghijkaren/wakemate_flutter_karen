import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/providers/locale_provider.dart';
import 'package:my_app/gen_l10n/app_localizations.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({super.key});

  static const Color _primaryColor = Color(0xFF1F3D5B);
  static const Color _accentColor = Color(0xFF4DB6AC);
  static const Color _lightColor = Color(0xFFF7F9FC);

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final l10n = AppLocalizations.of(context)!;
    final String selectedLanguage = localeProvider.localeCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.languageSettingsTitle,
          style: const TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: _primaryColor),
      ),
      backgroundColor: _lightColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            l10n.selectYourLanguage,
            style: TextStyle(
              color: _primaryColor.withOpacity(0.7),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildLanguageTile(context, 'English', 'en', selectedLanguage),
                const Divider(height: 1, indent: 20, endIndent: 20),
                _buildLanguageTile(context, '繁體中文', 'zh_TW', selectedLanguage),
                const Divider(height: 1, indent: 20, endIndent: 20),
                _buildLanguageTile(context, 'Bahasa Indonesia', 'id', selectedLanguage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    String title,
    String languageCode,
    String selectedLanguage,
  ) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: const TextStyle(
          color: _primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      value: languageCode,
      groupValue: selectedLanguage,
      onChanged: (String? value) {
        if (value != null && value != selectedLanguage) {
          context.read<LocaleProvider>().setLocale(value);
        }
      },
      activeColor: _accentColor,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}