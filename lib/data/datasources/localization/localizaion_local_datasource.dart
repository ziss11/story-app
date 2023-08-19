import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/utils/app_constants.dart';

abstract class LocalizationLocalDataSource {
  Future<bool> setLocale(String code);
  Locale? getLocale();
}

class LocalizationLocalDataSourceImpl implements LocalizationLocalDataSource {
  final SharedPreferences _preferences;

  const LocalizationLocalDataSourceImpl(this._preferences);

  @override
  Future<bool> setLocale(String code) async {
    return _preferences.setString(AppConstants.localeKey, code);
  }

  @override
  Locale? getLocale() {
    final code = _preferences.getString(AppConstants.localeKey);
    return (code == null) ? null : Locale(code);
  }
}
