final class ApiToken {
  final String value;
  final String type;

  ApiToken({required this.value, required this.type});

  factory ApiToken.fromJson(Map<String, dynamic> json) {
    return ApiToken(
      value: json['token'],
      type: json['type'],
    );
  }
}