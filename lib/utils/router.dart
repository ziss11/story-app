import 'package:go_router/go_router.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/presentation/pages/add_story_page.dart';
import 'package:story_app/presentation/pages/home_page.dart';
import 'package:story_app/presentation/pages/sign_in_page.dart';
import 'package:story_app/presentation/pages/sign_up_page.dart';

GoRouter configureRouter(AuthCubit authCubit) {
  final router = GoRouter(
    routerNeglect: false,
    initialLocation:
        authCubit.state is Authenticated ? HomePage.path : SignInPage.path,
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
          ),
        ],
      ),
    ],
  );

  return router;
}
