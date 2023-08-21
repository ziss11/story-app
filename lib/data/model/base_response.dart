import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse extends Equatable {
  final bool error;
  final String message;

  const BaseResponse({required this.error, required this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> map) =>
      _$BaseResponseFromJson(map);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  @override
  List<Object?> get props => [error, message];
}
