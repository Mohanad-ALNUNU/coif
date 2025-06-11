import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLocale = 'fr';

  String get currentLocale => _currentLocale;

  Future<void> setLocale(String locale) async {
    _currentLocale = locale;
    notifyListeners();
  }

  Future<void> loadSavedLocale() async {
    // Default to English
    _currentLocale = 'fr';
    notifyListeners();
  }

  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'fr', 'name': 'Français'},
    {'code': 'en', 'name': 'English'},
    {'code': 'ar', 'name': 'العربية'},
  ];
} 