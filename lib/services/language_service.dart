import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'language';
  late SharedPreferences _prefs;
  Locale _locale = const Locale('ru');

  Locale get locale => _locale;

  LanguageService() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    _prefs = await SharedPreferences.getInstance();
    final languageCode = _prefs.getString(_languageKey) ?? 'ru';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _prefs.setString(_languageKey, locale.languageCode);
    notifyListeners();
  }
} 