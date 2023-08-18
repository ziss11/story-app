import 'package:equatable/equatable.dart';

class BaseResponse<T> extends Equatable {
  final bool error;
  final String message;
  final T? data;

  const BaseResponse({
    required this.error,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> map, [T? data]) =>
      BaseResponse(
        error: map['error'],
        message: map['message'],
        data: data,
      );

  @override
  List<Object?> get props => [error, message, data];
}
