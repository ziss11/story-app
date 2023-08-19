part of 'localization_cubit.dart';

class LocalizationState extends Equatable {
  final Locale locale;

  const LocalizationState({required this.locale});

  @override
  List<Object?> get props => [locale];
}
