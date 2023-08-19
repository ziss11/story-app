class BaseResponse {
  final bool error;
  final String message;

  BaseResponse({required this.error, required this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> map) {
    return BaseResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }
}
