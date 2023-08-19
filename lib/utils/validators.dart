import 'package:flutter/material.dart';
import 'package:story_app/utils/common.dart';

abstract class Validators {
  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyEmailAlert;
    }

    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!isValid) {
      return AppLocalizations.of(context)!.emailAlert;
    }

    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyPasswordAlert;
    }

    bool isValid = value.length < 8;

    if (isValid) {
      return AppLocalizations.of(context)!.passwordAlert;
    }

    return null;
  }

  static String? validateDesc(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyDescAlert;
    }

    return null;
  }
}
