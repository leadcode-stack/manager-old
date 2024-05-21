import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/authentication/data/models/api_token.dart';

final class Auth {
  User? user;
  ApiToken? token;

  bool isLoggedIn = false;

  Auth({this.user, this.token});
}

final authProvider = Provider<Auth>((ref) {
  return Auth(user: null, token: null);
});
