import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/cubit/media/media_cubit.dart';
import 'package:story_app/cubit/story/story_cubit.dart';
import 'package:story_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:story_app/data/datasources/auth/auth_remote_datasource.dart';
import 'package:story_app/data/datasources/localization/localizaion_local_datasource.dart';
import 'package:story_app/data/datasources/story/story_remote_datasource.dart';

abstract class Injection {
  static final locator = GetIt.instance;

  static Future<void> init() async {
    // cubits
    locator
        .registerFactory<LocalizationCubit>(() => LocalizationCubit(locator()));

    locator.registerFactory<AuthCubit>(() => AuthCubit(locator(), locator()));

    locator.registerFactory<StoryCubit>(() => StoryCubit(locator(), locator()));

    locator.registerFactory<MediaCubit>(() => MediaCubit(locator()));

    // data sources
    locator.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(locator()));

    locator.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(locator()));

    locator.registerLazySingleton<StoryRemoteDataSource>(
        () => StoryRemoteDataSourceImpl(locator()));

    locator.registerLazySingleton<LocalizationLocalDataSource>(
        () => LocalizationLocalDataSourceImpl(locator()));

    // helper
    locator.registerSingleton<SharedPreferences>(
        await SharedPreferences.getInstance());

    // external
    locator.registerLazySingleton<ImagePicker>(() => ImagePicker());
    locator.registerLazySingleton<Dio>(() => Dio());
  }
}
