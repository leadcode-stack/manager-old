import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/authentication/data/models/api_token.dart';

final class AuthLoginResponse {
  final ApiToken token;
  final User user;

  AuthLoginResponse({required this.token, required this.user});

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponse(
      token: ApiToken.fromJson(json['token']),
      user: User.fromJson(json['user']),
    );
  }
}