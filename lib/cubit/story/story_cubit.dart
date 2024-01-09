import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:story_app/data/datasources/story/story_remote_datasource.dart';
import 'package:story_app/data/model/story_model.dart';
import 'package:story_app/utils/common.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  final StoryRemoteDataSource _storyRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  StoryCubit(this._storyRemoteDataSource, this._authLocalDataSource)
      : super(StoryInitial());

  int? page = 1;
  int size = 10;

  void addStory(BuildContext context, List<int> bytes, String filename,
      String description, LatLng? latLng) async {
    final message = AppLocalizations.of(context)!.unableLoadStoryMessage;

    try {
      emit(StoryLoading());

      final token = _authLocalDataSource.getToken();
      await _storyRemoteDataSource.addStory(
          token!, bytes, filename, description, latLng);

      emit(UploadStorySuccess());
    } catch (e) {
      emit(
        StoryFailed(message: message),
      );
    }
  }

  void getStories(BuildContext context, [bool restart = false]) async {
    final message = AppLocalizations.of(context)!.unableLoadStoryMessage;

    try {
      final newPage = restart ? 1 : page ?? 1;

      if (newPage == 1) emit(StoryLoading());

      final token = _authLocalDataSource.getToken();
      final result = await _storyRemoteDataSource.getStories(token!,
          page: newPage, size: size);

      page = result.length < size ? null : newPage + 1;

      if (result.isEmpty) {
        if (state is StorySuccess) {
          final currentState = state as StorySuccess;
          emit(currentState.stories.isEmpty ? StoryInitial() : currentState);
        }
      } else {
        if (state is StorySuccess) {
          final currentState = state as StorySuccess;
          final updatedStory = [...currentState.stories, ...result];
          emit(StorySuccess(stories: updatedStory, page: page, size: size));
        } else {
          emit(StorySuccess(stories: result, page: page, size: size));
        }
      }
    } catch (e) {
      emit(
        StoryFailed(message: message),
      );
    }
  }
}
