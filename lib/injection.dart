import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/data/datasources/auth_remote_datasource.dart';

abstract class Injection {
  static final locator = GetIt.instance;

  static void init() {
    // cubits
    locator.registerFactory<LocalizationCubit>(() => LocalizationCubit());
    locator.registerFactory<AuthCubit>(() => AuthCubit(locator()));

    // data sources
    locator.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(locator()));

    // external
    locator.registerLazySingleton<Dio>(() => Dio());
  }
}
