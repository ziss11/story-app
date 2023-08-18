import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:story_app/data/datasources/auth/auth_remote_datasource.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthCubit(this._remoteDataSource, this._localDataSource)
      : super(AuthInitial());

  void checkStatus() {
    final token = _localDataSource.getToken();

    if (token != null && token.isNotEmpty) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      await _remoteDataSource.register(name, email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(const AuthFailed(message: 'Email telah digunakan'));
    }
  }

  void login(String email, String password) async {
    emit(AuthLoading());
    final token = await _remoteDataSource.login(email, password);

    if (await _localDataSource.saveToken(token)) {
      emit(AuthSuccess());
    } else {
      emit(const AuthFailed(message: 'Email atau password anda salah'));
    }
  }

  void logout() async {
    emit(AuthLoading());
    final isSuccess = await _localDataSource.deleteToken();

    if (isSuccess) {
      emit(Unauthenticated());
    }
  }
}
