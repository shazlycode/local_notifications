import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationsProvider with ChangeNotifier {
  bool? _isEnglish = true;

  bool get isEnglish => _isEnglish!;

  Future<void> selectEnglish(BuildContext context) async {
    await context.setLocale(Locale('en'));
    _isEnglish = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglish', _isEnglish!);
    notifyListeners();
  }

  Future<void> selectArabic(BuildContext context) async {
    await context.setLocale(Locale('ar'));
    _isEnglish = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglish', _isEnglish!);
    notifyListeners();
  }

  getLang() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnglish = prefs.getBool('isEnglish') ?? false;
    notifyListeners();
  }

  LocalizationsProvider() {
    getLang();
    notifyListeners();
  }
}
