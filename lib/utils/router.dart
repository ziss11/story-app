import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/presentation/pages/add_story_page.dart';
import 'package:story_app/presentation/pages/detail_story_page.dart';
import 'package:story_app/presentation/pages/home_page.dart';
import 'package:story_app/presentation/pages/maps_page.dart';
import 'package:story_app/presentation/pages/sign_in_page.dart';
import 'package:story_app/presentation/pages/sign_up_page.dart';

GoRouter configureRouter(AuthCubit authCubit) {
  final router = GoRouter(
    routerNeglect: false,
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: HomePage.path,
    redirectLimit: 1,
    redirect: (context, state) {
      if (authCubit.state is AuthInitial && state.fullPath == HomePage.path) {
        return SignInPage.path;
      } else if (authCubit.state is Authenticated &&
          state.fullPath == SignInPage.path) {
        return HomePage.path;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: SignInPage.path,
        name: SignInPage.routeName,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: SignUpPage.path,
        name: SignUpPage.routeName,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: HomePage.path,
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: AddStoryPage.path,
            name: AddStoryPage.routeName,
            builder: (context, state) => const AddStoryPage(),
            routes: [
              GoRoute(
                path: MapsPage.pickPath,
                name: MapsPage.pickRouteName,
                builder: (context, state) => const MapsPage(pick: true),
              ),
            ],
          ),
          GoRoute(
            path: DetailStoryPage.path,
            name: DetailStoryPage.routeName,
            builder: (context, state) {
              String id = state.pathParameters['id']!;
              LatLng? location = state.extra as LatLng?;
              return DetailStoryPage(id: id, location: location);
            },
            routes: [
              GoRoute(
                path: MapsPage.mapsPath,
                name: MapsPage.mapsRouteName,
                builder: (context, state) {
                  LatLng? latLng = state.extra as LatLng?;
                  return MapsPage(pick: false, latLang: latLng);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  return router;
}
