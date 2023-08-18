import 'package:flutter/material.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            color: AppColors.foregroundColor,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.blackColor2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.greyColor),
            prefixIcon: prefixIcon,
            prefixIconColor: AppColors.purpleColor,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 60,
            ),
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.greyColor,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 60,
            ),
          ),
        ),
      ],
    );
  }
}
