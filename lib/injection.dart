import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/cubit/location/location_cubit.dart';
import 'package:story_app/cubit/media/media_cubit.dart';
import 'package:story_app/cubit/story/story_cubit.dart';
import 'package:story_app/cubit/story_detail/story_detail_cubit.dart';
import 'package:story_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:story_app/data/datasources/auth/auth_remote_datasource.dart';
import 'package:story_app/data/datasources/localization/localizaion_local_datasource.dart';
import 'package:story_app/data/datasources/story/story_remote_datasource.dart';

abstract class Injection {
  static Future<void> init() async {
    // cubits
    GetIt.I
        .registerFactory<LocalizationCubit>(() => LocalizationCubit(GetIt.I()));

    GetIt.I.registerFactory<AuthCubit>(() => AuthCubit(GetIt.I(), GetIt.I()));

    GetIt.I.registerFactory<StoryCubit>(() => StoryCubit(GetIt.I(), GetIt.I()));

    GetIt.I.registerFactory<StoryDetailCubit>(
        () => StoryDetailCubit(GetIt.I(), GetIt.I()));

    GetIt.I.registerFactory<MediaCubit>(() => MediaCubit(GetIt.I()));

    GetIt.I.registerFactory<LocationCubit>(() => LocationCubit());

    // data sources
    GetIt.I.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(GetIt.I()));

    GetIt.I.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(GetIt.I()));

    GetIt.I.registerLazySingleton<StoryRemoteDataSource>(
        () => StoryRemoteDataSourceImpl(GetIt.I()));

    GetIt.I.registerLazySingleton<LocalizationLocalDataSource>(
        () => LocalizationLocalDataSourceImpl(GetIt.I()));

    // helper
    GetIt.I.registerSingleton<SharedPreferences>(
        await SharedPreferences.getInstance());

    // external
    GetIt.I.registerLazySingleton<ImagePicker>(() => ImagePicker());
    GetIt.I.registerLazySingleton<Dio>(() => Dio());
  }
}
