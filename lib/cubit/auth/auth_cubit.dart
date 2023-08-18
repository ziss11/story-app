import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/datasources/auth_remote_datasource.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource _remoteDataSource;

  AuthCubit(this._remoteDataSource) : super(AuthInitial());

  void register(String name, String email, String password) async {
    try {
      emit(AuthLoading());

      final result = await _remoteDataSource.register(name, email, password);
      emit(AuthSuccess(message: result));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  void login(String email, String password) async {
    try {
      emit(AuthLoading());

      final result = await _remoteDataSource.login(email, password);
      emit(AuthSuccess(message: result));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }
}
