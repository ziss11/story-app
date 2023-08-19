import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:story_app/cubit/media/media_cubit.dart';
import 'package:story_app/cubit/story/story_cubit.dart';
import 'package:story_app/presentation/pages/home_page.dart';
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

  late TextEditingController descController;

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
        context
            .read<StoryCubit>()
            .addStory(context, newBytes, filename, descController.text);
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
    return KeyboardDismisser(
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
                        child: Text(AppLocalizations.of(context)!.cameraLabel),
                      ),
                      const SizedBox(width: 16),
                      AppButton(
                        onPressed: context.read<MediaCubit>().onGalleryView,
                        backgroundColor: AppColors.purpleColor,
                        child: Text(AppLocalizations.of(context)!.galleryLabel),
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
                  const SizedBox(height: 16),
                  BlocConsumer<StoryCubit, StoryState>(
                    listener: (context, state) {
                      if (state is UploadStorySuccess) {
                        context.goNamed(HomePage.routeName);
                        context.read<MediaCubit>().setImage(null, null);
                        context.read<StoryCubit>().getStories(context);
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        width: MediaQuery.of(context).size.width,
                        onPressed: _onUpload,
                        child: (state is StoryLoading)
                            ? const Center(
                                child: CircularProgressIndicator(
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
    );
  }
}
