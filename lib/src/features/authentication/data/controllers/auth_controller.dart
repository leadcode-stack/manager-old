import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/application/preferences/shared_preferences.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/authentication/data/models/api_token.dart';
import 'package:manager/src/features/authentication/data/models/auth.dart';
import 'package:manager/src/features/authentication/data/models/auth_login_response.dart';
import 'package:manager/src/features/authentication/data/repositories/auth_repository.dart';

final class AuthController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<User> me() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.me()
      .then((response) => jsonDecode(response.body))
      .then((body) => User.fromJson(body));
  }

  Future<void> load() async {
    final auth = ref.read(authProvider);
    final preferences = ref.read(sharedPreferencesProvider);

    final token = preferences.getString('token');
    if (token != null) {
      auth.token = ApiToken(type: 'Bearer', value: token);
      auth.user = await me();
      auth.isLoggedIn = true;
    }
  }

  Future<void> login(String email, String password) async {
    final auth = ref.read(authProvider);
    final authRepository = ref.read(authRepositoryProvider);

    final response = await authRepository.login(email, password)
      .then((response) => jsonDecode(response.body))
      .then((body) => AuthLoginResponse.fromJson(body));

    auth.user = response.user;
    auth.token = response.token;
    auth.isLoggedIn = true;

    final preferences = ref.read(sharedPreferencesProvider);
    preferences.setString('token', auth.token!.value);
  }
}

final authControllerProvider =
    AsyncNotifierProvider.autoDispose<AuthController, void>(AuthController.new);
