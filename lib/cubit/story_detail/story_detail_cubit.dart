import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:story_app/data/datasources/story/story_remote_datasource.dart';
import 'package:story_app/data/model/story_model.dart';
import 'package:story_app/utils/common.dart';

part 'story_detail_state.dart';

class StoryDetailCubit extends Cubit<StoryDetailState> {
  final StoryRemoteDataSource _storyRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  StoryDetailCubit(this._storyRemoteDataSource, this._authLocalDataSource)
      : super(StoryDetailInitial());

  void getDetailStory(BuildContext context, String id) async {
    final message = AppLocalizations.of(context)!.unableLoadStoryMessage;
    try {
      emit(StoryDetailLoading());

      final token = _authLocalDataSource.getToken();
      final result = await _storyRemoteDataSource.getDetailStory(token!, id);

      emit(StoryDetailSuccess(story: result));
    } catch (e) {
      emit(
        StoryDetailFailed(message: message),
      );
    }
  }
}
