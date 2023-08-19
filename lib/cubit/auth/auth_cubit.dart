import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:story_app/data/datasources/auth/auth_remote_datasource.dart';
import 'package:story_app/utils/common.dart';

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

  void register(
      BuildContext context, String name, String email, String password) async {
    try {
      emit(AuthLoading());
      await _remoteDataSource.register(name, email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(
        AuthFailed(
          message: AppLocalizations.of(context)!.loginErrorMessage,
        ),
      );
    }
  }

  void login(BuildContext context, String email, String password) async {
    try {
      emit(AuthLoading());

      final token = await _remoteDataSource.login(email, password);
      await _localDataSource.saveToken(token);

      emit(AuthSuccess());
    } catch (e) {
      emit(
        AuthFailed(
          message: AppLocalizations.of(context)!.registerErrorMessage,
        ),
      );
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
