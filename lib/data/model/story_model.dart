import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_model.g.dart';

@JsonSerializable()
class StoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  @JsonKey(name: 'lat')
  final double? latitude;
  @JsonKey(name: 'lon')
  final double? longitude;

  const StoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        photoUrl,
        createdAt,
        latitude,
        longitude,
      ];
}
