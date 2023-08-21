import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/data/model/story_model.dart';

part 'story_response.g.dart';

@JsonSerializable()
class StoryResponse extends Equatable {
  @JsonKey(name: 'listStory')
  final List<StoryModel> stories;

  const StoryResponse({required this.stories});

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseToJson(this);

  @override
  List<Object?> get props => [stories];
}
