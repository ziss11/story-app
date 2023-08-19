import 'package:equatable/equatable.dart';

class StoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final double? latitude;
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

  factory StoryModel.fromJson(Map<String, dynamic> map) => StoryModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        photoUrl: map['photoUrl'],
        createdAt: DateTime.parse(map['createdAt']),
        latitude: map['lat'],
        longitude: map['lon'],
      );

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
