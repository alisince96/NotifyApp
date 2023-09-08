class SignUpResponse {
  bool? result;
  String? message;
  int? userId;

  SignUpResponse({
    this.result,
    this.message,
    this.userId,
  });
  SignUpResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message']?.toString();
    userId = json['user_id']?.toInt();
  }
}
