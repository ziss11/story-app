part of 'story_cubit.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

final class StoryInitial extends StoryState {}

final class StoryLoading extends StoryState {}

final class UploadStorySuccess extends StoryState {}

final class StorySuccess extends StoryState {
  final List<StoryModel> stories;
  final int? page;
  final int size;

  const StorySuccess({
    required this.stories,
    required this.page,
    required this.size,
  });

  @override
  List<Object> get props => [stories, page ?? 0, size];
}

final class StoryFailed extends StoryState {
  final String message;

  const StoryFailed({required this.message});

  @override
  List<Object> get props => [message];
}
