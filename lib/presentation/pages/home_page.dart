import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/cubit/story/story_cubit.dart';
import 'package:story_app/presentation/pages/add_story_page.dart';
import 'package:story_app/presentation/pages/detail_story_page.dart';
import 'package:story_app/presentation/pages/sign_in_page.dart';
import 'package:story_app/presentation/widgets/app_shimmer.dart';
import 'package:story_app/presentation/widgets/flag_icon_widget.dart';
import 'package:story_app/presentation/widgets/story_card.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  static const path = '/';
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final storyCubit = context.read<StoryCubit>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (storyCubit.page != null) storyCubit.getStories(context);
      }
    });

    Future.microtask(() async => storyCubit.getStories(context));

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

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
        if (state is AuthInitial) {
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
        body: SafeArea(
          child: BlocBuilder<StoryCubit, StoryState>(
            builder: (context, state) {
              if (state is StoryLoading) {
                return ListView.separated(
                  itemCount: 10,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    return AppShimmer(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    );
                  },
                );
              } else if (state is StoryListSuccess) {
                return ListView.separated(
                  controller: scrollController,
                  itemCount: state.stories.length,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    final story = state.stories[index];
                    return StoryCard(
                      onTap: () => context.pushNamed(
                        DetailStoryPage.routeName,
                        pathParameters: {'id': story.id},
                      ),
                      story: story,
                    );
                  },
                );
              } else if (state is StoryFailed) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      color: AppColors.foregroundColor,
                    ),
                  ),
                );
              } else if (state is StoryInitial) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.emptyStoryMessage,
                    style: const TextStyle(
                      color: AppColors.foregroundColor,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
