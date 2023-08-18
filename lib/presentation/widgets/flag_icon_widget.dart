import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/cubit/localization/localization_cubit.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/localization_config.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        dropdownColor: AppColors.blackColor2,
        icon: const Icon(
          Icons.flag_rounded,
          color: AppColors.foregroundColor,
        ),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = LocalizationConfig.getFlag(locale.languageCode);
          return DropdownMenuItem(
            onTap: () {
              context.read<LocalizationCubit>().setLocale(locale);
            },
            value: locale,
            child: Center(
              child: Text(flag),
            ),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
