import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:manager/src/application/http/http_client.dart';
import 'package:manager/src/constants/http.dart';
import 'package:manager/src/features/authentication/data/models/auth.dart';

final class AuthRepository {
  final ProviderRef _ref;
  final http.Client _client;

  AuthRepository(this._ref, this._client);

  Future<http.Response> me () async {
    final preferences = _ref.read(authProvider);

    return _client.get(
      Uri.parse('$baseApiUrl/authentication/me'),
      headers: {
        'Authorization': 'Bearer ${preferences.token!.value}',
      },
    );
  }

  Future<http.Response> login(String email, String password) async {
    return _client.post(
      Uri.parse('$baseApiUrl/authentication/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.read(httpClient);
  return AuthRepository(ref, client);
});