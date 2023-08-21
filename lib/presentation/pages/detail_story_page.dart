import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/cubit/location/location_cubit.dart';
import 'package:story_app/cubit/story_detail/story_detail_cubit.dart';
import 'package:story_app/presentation/pages/maps_page.dart';
import 'package:story_app/presentation/widgets/app_shimmer.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class DetailStoryPage extends StatefulWidget {
  static const path = ':id';
  static const routeName = 'detail-story';

  final String id;
  final LatLng? location;

  const DetailStoryPage({super.key, required this.id, this.location});

  @override
  State<DetailStoryPage> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends State<DetailStoryPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<StoryDetailCubit>().getDetailStory(context, widget.id);

      if (widget.location != null) {
        context.read<LocationCubit>().getPlacemarkFromLatLng(
              widget.location!,
              Localizations.localeOf(context).languageCode,
            );
      }
    });
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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.foregroundColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              if (story.latitude != null &&
                                  story.longitude != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_pin,
                                      size: 14,
                                      color: AppColors.foregroundColor,
                                    ),
                                    const SizedBox(width: 3),
                                    BlocBuilder<LocationCubit, LocationState>(
                                      builder: (context, state) {
                                        if (state is LocationSuccess) {
                                          final subAdministrativeArea = state
                                              .placemark?.subAdministrativeArea;
                                          final country =
                                              state.placemark?.country;
                                          return Text(
                                            '$subAdministrativeArea, $country',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.greyColor,
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                    const SizedBox(width: 3),
                                    dotIcon(),
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () => context.goNamed(
                                        MapsPage.mapsRouteName,
                                        pathParameters: {'id': story.id},
                                        extra: LatLng(
                                          story.latitude!,
                                          story.longitude!,
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .seeLocation,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.foregroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: story.photoUrl,
                      fit: BoxFit.cover,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Row(
                        children: [
                          Text(
                            story.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.foregroundColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            story.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.foregroundColor,
                            ),
                          ),
                        ],
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

  Widget dotIcon() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
    );
  }
}
