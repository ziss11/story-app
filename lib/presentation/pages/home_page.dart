import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/presentation/pages/add_story_page.dart';
import 'package:story_app/presentation/pages/sign_in_page.dart';
import 'package:story_app/presentation/widgets/flag_icon_widget.dart';
import 'package:story_app/presentation/widgets/story_card.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  static const path = '/';
  static const routeName = 'home';

  const HomePage({super.key});

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.blackColor4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          AppLocalizations.of(context)!.logoutMessage,
          style: const TextStyle(
            color: AppColors.foregroundColor,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: context.pop,
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(
                color: AppColors.redColor,
              ),
            ),
          ),
          TextButton(
            onPressed: context.read<AuthCubit>().logout,
            child: Text(
              AppLocalizations.of(context)!.ok,
              style: const TextStyle(
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.goNamed(SignInPage.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Story',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            const FlagIconWidget(),
            IconButton(
              onPressed: () => logout(context),
              icon: const Icon(
                Icons.logout,
                color: AppColors.redColor,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.lightBlueColor,
          foregroundColor: AppColors.foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () => context.pushNamed(
            AddStoryPage.routeName,
          ),
          child: const Icon(Icons.add_a_photo),
        ),
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            return const StoryCard();
          },
        ),
      ),
    );
  }
}