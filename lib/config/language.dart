import 'package:flutter/material.dart';

class AppLanguage {
  static const Locale zh = Locale('zh', 'CN');
  static const Locale en = Locale('en', 'US');

  static const List<Locale> supportedLocales = [zh, en];

  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        return '中文';
      case 'en':
        return 'English';
      default:
        return '中文';
    }
  }
}

