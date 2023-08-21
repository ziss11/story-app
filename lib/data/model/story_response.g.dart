// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryResponse _$StoryResponseFromJson(Map<String, dynamic> json) =>
    StoryResponse(
      stories: (json['listStory'] as List<dynamic>)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryResponseToJson(StoryResponse instance) =>
    <String, dynamic>{
      'listStory': instance.stories,
    };
