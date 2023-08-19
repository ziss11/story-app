part of 'story_cubit.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

final class StoryInitial extends StoryState {}

final class StoryLoading extends StoryState {}

final class UploadStorySuccess extends StoryState {}

final class StoryListSuccess extends StoryState {
  final List<StoryModel> stories;

  const StoryListSuccess({required this.stories});

  @override
  List<Object> get props => [stories];
}

final class DetailStorySuccess extends StoryState {
  final StoryModel story;

  const DetailStorySuccess({required this.story});

  @override
  List<Object> get props => [story];
}

final class StoryFailed extends StoryState {
  final String message;

  const StoryFailed({required this.message});

  @override
  List<Object> get props => [message];
}
