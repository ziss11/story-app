import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: AppColors.blackColor3,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  'Abdul Azis',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.foregroundColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: ExpandableText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                  style: const TextStyle(
                    color: AppColors.foregroundColor,
                    fontWeight: FontWeight.w400,
                  ),
                  expandText: 'more',
                  collapseText: 'less',
                  maxLines: 2,
                  linkColor: AppColors.foregroundColor.withOpacity(.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
