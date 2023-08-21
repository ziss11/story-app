part of 'localization_cubit.dart';

final class LocalizationState extends Equatable {
  final Locale locale;

  const LocalizationState({required this.locale});

  @override
  List<Object?> get props => [locale];
}
