import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:story_app/data/datasources/auth/auth_remote_datasource.dart';

abstract class Injection {
  static final locator = GetIt.instance;

  static Future<void> init() async {
    // cubits
    locator.registerFactory<LocalizationCubit>(() => LocalizationCubit());

    locator.registerFactory<AuthCubit>(() => AuthCubit(locator(), locator()));

    // data sources
    locator.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(locator()));

    locator.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(locator()));

    // helper
    locator.registerSingleton<SharedPreferences>(
        await SharedPreferences.getInstance());

    // external
    locator.registerLazySingleton<Dio>(() => Dio());
  }
}
