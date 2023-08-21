part of 'story_detail_cubit.dart';

sealed class StoryDetailState extends Equatable {
  const StoryDetailState();

  @override
  List<Object> get props => [];
}

final class StoryDetailInitial extends StoryDetailState {}

final class StoryDetailLoading extends StoryDetailState {}

final class StoryDetailSuccess extends StoryDetailState {
  final StoryModel story;

  const StoryDetailSuccess({required this.story});

  @override
  List<Object> get props => [story];
}

final class StoryDetailFailed extends StoryDetailState {
  final String message;

  const StoryDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}
