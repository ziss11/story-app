import 'package:dio/dio.dart';
import 'package:story_app/data/model/base_response.dart';
import 'package:story_app/utils/app_constants.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse> register(String name, String email, String password);
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
  Future<BaseResponse> register(
      String name, String email, String password) async {
    final body = {'name': name, 'email': email, 'password': password};
    final response = await _dio.post(
      '${AppConstants.baseUrl}${AppConstants.registerPath}',
      data: body,
    );
    if (response.statusCode == 201) {
      final result = BaseResponse.fromJson(response.data);
      return result;
    } else {
      throw Exception();
    }
  }
}
