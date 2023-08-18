import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';

import '../injection.dart';

final providers = [
  BlocProvider<LocalizationCubit>(create: (_) => Injection.locator()),
  BlocProvider<AuthCubit>(create: (_) {
    final authBloc = Injection.locator<AuthCubit>();
    authBloc.checkStatus();
    return authBloc;
  }),
];
