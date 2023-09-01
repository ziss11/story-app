import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/cubit/location/location_cubit.dart';
import 'package:story_app/cubit/media/media_cubit.dart';
import 'package:story_app/cubit/story/story_cubit.dart';
import 'package:story_app/cubit/story_detail/story_detail_cubit.dart';

final providers = [
  BlocProvider<AuthCubit>(create: (_) => GetIt.I()),
  BlocProvider<LocalizationCubit>(create: (_) => GetIt.I()),
  BlocProvider<StoryCubit>(create: (_) => GetIt.I()),
  BlocProvider<StoryDetailCubit>(create: (_) => GetIt.I()),
  BlocProvider<LocationCubit>(create: (_) => GetIt.I()),
  BlocProvider<MediaCubit>(create: (_) => GetIt.I()),
];
