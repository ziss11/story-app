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
    try {
      emit(StoryLoading());

      final token = _authLocalDataSource.getToken();
      await _storyRemoteDataSource.addStory(
          token!, bytes, filename, description, latLng);

      emit(UploadStorySuccess());
    } catch (e) {
      emit(
        StoryFailed(
          message: AppLocalizations.of(context)!.unableLoadStoryMessage,
        ),
      );
    }
  }

  void getStories(BuildContext context, [bool restart = false]) async {
    try {
      if (page == 1) emit(StoryLoading());

      final token = _authLocalDataSource.getToken();
      final result = await _storyRemoteDataSource.getStories(token!,
          page: restart ? 1 : page!, size: size);

      if (result.length < size) {
        page = null;
      } else {
        page = page! + 1;
      }

      if (result.isEmpty) {
        if (state is StorySuccess) {
          final currentState = state as StorySuccess;

          if (currentState.stories.isEmpty) {
            emit(StoryInitial());
          } else {
            emit(StorySuccess(
                stories: currentState.stories, page: page, size: size));
          }
        }
      } else {
        if (state is StorySuccess) {
          final currentState = state as StorySuccess;
          final updatedStory = List.of(currentState.stories)..addAll(result);

          emit(StorySuccess(stories: updatedStory, page: page, size: size));
        } else {
          emit(StorySuccess(stories: result, page: page, size: size));
        }
      }
    } catch (e) {
      emit(
        StoryFailed(
          message: AppLocalizations.of(context)!.unableLoadStoryMessage,
        ),
      );
    }
  }
}
