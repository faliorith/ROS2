import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'theme';
  late SharedPreferences _prefs;
  ThemeMode _themeMode = ThemeMode.system;
  bool _isInitialized = false;

  ThemeMode get themeMode => _themeMode;

  ThemeService() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final theme = _prefs.getString(_themeKey) ?? 'system';
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == 'ThemeMode.$theme',
        orElse: () => ThemeMode.system,
      );
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Ошибка при инициализации темы: $e');
      _themeMode = ThemeMode.system;
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (!_isInitialized) {
      await _initialize();
    }
    try {
      _themeMode = mode;
      await _prefs.setString(_themeKey, mode.toString().split('.').last);
      notifyListeners();
    } catch (e) {
      debugPrint('Ошибка при сохранении темы: $e');
    }
  }
} 