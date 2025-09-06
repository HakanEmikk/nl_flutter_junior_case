class ResponseInfo {
  final int code;
  final String message;

  ResponseInfo({required this.code, required this.message});

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
