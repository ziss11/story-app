import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(const Locale('en'));

  void setLocale(Locale locale) {
    emit(locale);
    debugPrint(locale.toLanguageTag());
  }
}
