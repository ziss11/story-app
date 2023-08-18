import 'package:flutter/material.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class AppTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const AppTextArea({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 6,
      maxLines: null,
      controller: controller,
      style: const TextStyle(
        color: AppColors.foregroundColor,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1.5,
            color: AppColors.blackColor3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1.5,
            color: AppColors.blackColor3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1.5,
            color: AppColors.blackColor3,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.greyColor),
      ),
    );
  }
}
