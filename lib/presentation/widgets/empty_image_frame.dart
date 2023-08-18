import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class EmptyImageFrame extends StatelessWidget {
  final double width;
  final double height;

  const EmptyImageFrame({
    super.key,
    this.width = double.infinity,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DottedBorder(
        dashPattern: const [10, 6],
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        color: AppColors.blackColor3,
        strokeWidth: 2,
        child: const Center(
          child: Icon(
            Icons.photo_library_rounded,
            color: AppColors.blackColor3,
            size: 150,
          ),
        ),
      ),
    );
  }
}
