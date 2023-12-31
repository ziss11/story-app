import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/utils/providers.dart';
import 'package:story_app/utils/router.dart';
import 'package:story_app/utils/styles/app_colors.dart';

import 'injection.dart';
import 'utils/common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();
          final router = configureRouter(authCubit);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            backButtonDispatcher: RootBackButtonDispatcher(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: AppColors.foregroundColor,
              ),
              primaryColor: AppColors.purpleColor,
              scaffoldBackgroundColor: AppColors.backgroundColor,
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
          );
        },
      ),
    );
  }
}
