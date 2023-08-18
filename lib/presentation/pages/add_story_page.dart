import 'package:flutter/material.dart';
import 'package:story_app/presentation/widgets/app_button.dart';
import 'package:story_app/presentation/widgets/app_textarea.dart';
import 'package:story_app/presentation/widgets/empty_image_frame.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class AddStoryPage extends StatefulWidget {
  static const path = 'new-story';
  static const routeName = 'new-story';

  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  late TextEditingController descController;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.newStoryTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              const EmptyImageFrame(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    onPressed: () {},
                    backgroundColor: AppColors.purpleColor,
                    child: Text(AppLocalizations.of(context)!.cameraLabel),
                  ),
                  const SizedBox(width: 16),
                  AppButton(
                    onPressed: () {},
                    backgroundColor: AppColors.purpleColor,
                    child: Text(AppLocalizations.of(context)!.galleryLabel),
                  )
                ],
              ),
              const SizedBox(height: 20),
              AppTextArea(
                controller: descController,
                hint: AppLocalizations.of(context)!.descHint,
              ),
              const SizedBox(height: 16),
              AppButton(
                width: MediaQuery.of(context).size.width,
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.uploadLabel),
              )
            ],
          ),
        ),
      ),
    );
  }
}
