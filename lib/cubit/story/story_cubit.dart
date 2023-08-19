import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void addStory(BuildContext context, List<int> bytes, String filename,
      String description) async {
    try {
      emit(StoryLoading());

      final token = _authLocalDataSource.getToken();
      await _storyRemoteDataSource.addStory(
          token!, bytes, filename, description);

      emit(UploadStorySuccess());
    } catch (e) {
      emit(
        StoryFailed(
          message: AppLocalizations.of(context)!.unableLoadStoryMessage,
        ),
      );
    }
  }

  void getStories(BuildContext context) async {
    try {
      emit(StoryLoading());

      final token = _authLocalDataSource.getToken();
      final result = await _storyRemoteDataSource.getStories(token!);

      if (result.isNotEmpty) {
        emit(StoryListSuccess(stories: result));
      } else {
        emit(StoryInitial());
      }
    } catch (e) {
      emit(
        StoryFailed(
          message: AppLocalizations.of(context)!.unableLoadStoryMessage,
        ),
      );
    }
  }

  void getDetailStory(BuildContext context, int id) async {
    try {
      emit(StoryLoading());

      final token = _authLocalDataSource.getToken();
      final result = await _storyRemoteDataSource.getDetailStory(token!, id);

      emit(DetailStorySuccess(story: result));
    } catch (e) {
      emit(
        StoryFailed(
          message: AppLocalizations.of(context)!.unableLoadStoryMessage,
        ),
      );
    }
  }
}
