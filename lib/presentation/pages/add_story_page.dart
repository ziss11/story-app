import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:story_app/cubit/media/media_cubit.dart';
import 'package:story_app/cubit/story/story_cubit.dart';
import 'package:story_app/data/model/map_result.dart';
import 'package:story_app/presentation/pages/maps_page.dart';
import 'package:story_app/presentation/widgets/animated_circular_indicator.dart';
import 'package:story_app/presentation/widgets/app_button.dart';
import 'package:story_app/presentation/widgets/app_textarea.dart';
import 'package:story_app/presentation/widgets/image_frame.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';
import 'package:story_app/utils/validators.dart';

class AddStoryPage extends StatefulWidget {
  static const path = 'new-story';
  static const routeName = 'new-story';

  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final _formKey = GlobalKey<FormState>();

  MapsResult? mapsResult;
  late TextEditingController descController;

  String? get placeName {
    final administrativeArea = mapsResult?.placemark?.administrativeArea;
    final subAdministrativeArea = mapsResult?.placemark?.subAdministrativeArea;
    final country = mapsResult?.placemark?.country;

    if (administrativeArea == null &&
        country == null &&
        subAdministrativeArea == null) {
      return null;
    }
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  void _onUpload() async {
    if (_formKey.currentState!.validate()) {
      final mediaCubit = context.read<MediaCubit>();

      final imagePath = mediaCubit.state.imagePath;
      final imageFile = mediaCubit.state.imageFile;

      if (imagePath == null || imageFile == null) return;

      final filename = imageFile.name;
      final filebytes = await imageFile.readAsBytes();

      final newBytes = await mediaCubit.compressImage(filebytes);

      if (mounted) {
        context.read<StoryCubit>().addStory(
              context,
              newBytes,
              filename,
              descController.text,
              mapsResult?.latLng,
            );
      }
    }
  }

  @override
  void initState() {
    descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<MediaCubit>().setImage(null, null);
        return true;
      },
      child: KeyboardDismisser(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.newStoryTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    const ImageFrame(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          onPressed: context.read<MediaCubit>().onCameraView,
                          backgroundColor: AppColors.purpleColor,
                          child:
                              Text(AppLocalizations.of(context)!.cameraLabel),
                        ),
                        const SizedBox(width: 16),
                        AppButton(
                          onPressed: context.read<MediaCubit>().onGalleryView,
                          backgroundColor: AppColors.purpleColor,
                          child:
                              Text(AppLocalizations.of(context)!.galleryLabel),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: AppTextArea(
                        controller: descController,
                        hint: AppLocalizations.of(context)!.descHint,
                        validator: (value) =>
                            Validators.validateDesc(context, value),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        mapsResult =
                            await context.pushNamed(MapsPage.pickRouteName);
                        setState(() {});
                      },
                      title: Text(
                        (mapsResult?.placemark != null)
                            ? mapsResult?.placemark?.street ?? ''
                            : AppLocalizations.of(context)!.addLocationLabel,
                        style: const TextStyle(
                          color: AppColors.foregroundColor,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: placeName != null
                          ? Text(
                              placeName!,
                              style: const TextStyle(
                                color: AppColors.greyColor,
                              ),
                            )
                          : null,
                      trailing: Transform.rotate(
                        angle: pi,
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.foregroundColor,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocConsumer<StoryCubit, StoryState>(
                      listener: (context, state) {
                        if (state is UploadStorySuccess) {
                          context.pop(true);
                          context.read<MediaCubit>().setImage(null, null);
                        }
                      },
                      builder: (context, state) {
                        final mediaCubit = context.watch<MediaCubit>();
                        final imagePath = mediaCubit.state.imagePath;
                        final imageFile = mediaCubit.state.imageFile;
                        return AppButton(
                          width: MediaQuery.of(context).size.width,
                          onPressed: (imagePath == null || imageFile == null)
                              ? null
                              : _onUpload,
                          child: (state is StoryLoading)
                              ? const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: AnimatedCircularIndicator(
                                    color: AppColors.lightBlueColor,
                                  ),
                                )
                              : Text(AppLocalizations.of(context)!.uploadLabel),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
