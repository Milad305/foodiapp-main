class HttpResult {
  bool success;
  Map<String, dynamic> data;
  String message;

  HttpResult(
      {required this.success, required this.data, required this.message});

  factory HttpResult.fromJson(json) {
    return HttpResult(
        success: json['success'] as bool,
        data: json['data'] as Map<String, dynamic>,
        message: json['message'] as String);
  }
}
