import 'package:dio/dio.dart';
import 'package:story_app/utils/app_constants.dart';

abstract class AuthRemoteDataSource {
  Future<void> register(String name, String email, String password);
  Future<String> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<String> login(String email, String password) async {
    try {
      final body = {'email': email, 'password': password};
      final response = await _dio.post(
        '${AppConstants.baseUrl}${AppConstants.loginPath}',
        data: body,
      );

      final result = response.data['loginResult']['token'];
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      final body = {'name': name, 'email': email, 'password': password};
      await _dio.post(
        '${AppConstants.baseUrl}${AppConstants.registerPath}',
        data: body,
      );
    } catch (e) {
      throw Exception();
    }
  }
}
