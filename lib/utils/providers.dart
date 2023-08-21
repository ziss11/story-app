import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/cubit/location_picker/location_picker_cubit.dart';
import 'package:story_app/cubit/media/media_cubit.dart';
import 'package:story_app/cubit/story/story_cubit.dart';
import 'package:story_app/cubit/story_detail/story_detail_cubit.dart';

import '../injection.dart';

final providers = [
  BlocProvider<AuthCubit>(create: (_) => Injection.locator()),
  BlocProvider<LocalizationCubit>(create: (_) => Injection.locator()),
  BlocProvider<StoryCubit>(create: (_) => Injection.locator()),
  BlocProvider<StoryDetailCubit>(create: (_) => Injection.locator()),
  BlocProvider<LocationPickerCubit>(create: (_) => Injection.locator()),
  BlocProvider<MediaCubit>(create: (_) => Injection.locator()),
];
