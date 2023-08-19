import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/cubit/media/media_cubit.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class ImageFrame extends StatelessWidget {
  final double width;
  final double height;

  const ImageFrame({
    super.key,
    this.width = double.infinity,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: BlocBuilder<MediaCubit, MediaState>(
        builder: (context, state) {
          if (state.imagePath == null) {
            return DottedBorder(
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
            );
          } else {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(state.imagePath.toString()),
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }
}
