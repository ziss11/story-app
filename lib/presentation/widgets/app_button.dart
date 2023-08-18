import 'package:flutter/material.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.height = 50,
    this.backgroundColor = AppColors.purpleColor,
    this.foregroundColor = AppColors.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
