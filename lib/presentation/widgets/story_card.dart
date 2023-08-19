import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:story_app/data/model/story_model.dart';
import 'package:story_app/presentation/widgets/app_shimmer.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class StoryCard extends StatelessWidget {
  final Function() onTap;
  final StoryModel story;

  const StoryCard({super.key, required this.onTap, required this.story});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: AppColors.blackColor2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
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
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
