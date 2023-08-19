part of 'media_cubit.dart';

final class MediaState extends Equatable {
  final String? imagePath;
  final XFile? imageFile;

  const MediaState({this.imagePath, this.imageFile});

  @override
  List<Object?> get props => [imagePath, imageFile];
}
