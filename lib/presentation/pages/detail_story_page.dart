import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:story_app/cubit/story_detail/story_detail_cubit.dart';
import 'package:story_app/presentation/widgets/app_shimmer.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class DetailStoryPage extends StatefulWidget {
  static const path = ':id';
  static const routeName = 'detail-story';

  final String id;

  const DetailStoryPage({super.key, required this.id});

  @override
  State<DetailStoryPage> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends State<DetailStoryPage> {
  @override
  void initState() {
    Future.microtask(() =>
        context.read<StoryDetailCubit>().getDetailStory(context, widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.detailTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<StoryDetailCubit, StoryDetailState>(
          builder: (context, state) {
            if (state is StoryDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.purpleColor,
                ),
              );
            } else if (state is StoryDetailSuccess) {
              final story = state.story;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: story.photoUrl,
                        cacheManager: CacheManager(
                          Config(
                            'story-image',
                            stalePeriod: const Duration(days: 3),
                          ),
                        ),
                        placeholder: (context, url) => AppShimmer(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        story.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.foregroundColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        story.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.foregroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is StoryDetailFailed) {
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
    );
  }
}
