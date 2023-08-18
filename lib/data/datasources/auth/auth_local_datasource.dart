import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/utils/app_constants.dart';

abstract class AuthLocalDataSource {
  String? getToken();
  Future<bool> saveToken(String token);
  Future<bool> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _preferences;

  const AuthLocalDataSourceImpl(this._preferences);

  @override
  String? getToken() {
    final token = _preferences.getString(AppConstants.tokenKey);
    return token;
  }

  @override
  Future<bool> saveToken(String token) async {
    return await _preferences.setString(AppConstants.tokenKey, token);
  }

  @override
  Future<bool> deleteToken() async {
    return await _preferences.remove(AppConstants.tokenKey);
  }
}
