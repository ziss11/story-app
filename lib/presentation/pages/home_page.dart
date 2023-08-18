import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/presentation/pages/add_story_page.dart';
import 'package:story_app/presentation/pages/sign_in_page.dart';
import 'package:story_app/presentation/widgets/flag_icon_widget.dart';
import 'package:story_app/presentation/widgets/story_card.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  static const path = '/';
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () => context.goNamed(
              SignInPage.routeName,
            ),
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
    );
  }
}
