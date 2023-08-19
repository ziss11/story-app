import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/datasources/localization/localizaion_local_datasource.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final LocalizationLocalDataSource _localDataSource;

  LocalizationCubit(this._localDataSource)
      : super(const LocalizationState(locale: Locale('en'))) {
    _getLocale();
  }

  void setLocale(Locale locale) async {
    await _localDataSource.setLocale(locale.languageCode);
    emit(LocalizationState(locale: locale));
  }

  void _getLocale() {
    emit(LocalizationState(locale: _localDataSource.getLocale()));
  }
}
