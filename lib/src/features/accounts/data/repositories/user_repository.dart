import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:manager/src/application/preferences/shared_preferences.dart';
import 'package:manager/src/commons/utils/pagination.dart';
import 'package:manager/src/constants/http.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';

abstract interface class UserRepository {
  Future<Pagination<User>> getUsers();

  Future<User> getUser(int id);

  Future<User> update(int id, Map<String, dynamic> payload);
}

final class HttpUserRepository implements UserRepository {
  final ProviderRef _ref;
  final http.Client _client;

  HttpUserRepository(this._ref, this._client);

  @override
  Future<Pagination<User>> getUsers() async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .get(Uri.parse('$baseApiUrl/users'),
            headers: {'Authorization': 'Bearer $token'})
        .then((response) => jsonDecode(response.body))
        .then((data) => Pagination.of(data, User.fromJson));
  }

  @override
  Future<User> getUser(int id) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .get(Uri.parse('$baseApiUrl/users/$id'),
            headers: {'Authorization': 'Bearer $token'})
        .then((response) => jsonDecode(response.body))
        .then((data) => User.fromJson(data));
  }

  @override
  Future<User> update(int id, Map<String, dynamic> payload) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .put(Uri.parse('$baseApiUrl/users/$id'),
            body: jsonEncode(payload),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            })
        .then((response) => jsonDecode(response.body))
        .then((data) => User.fromJson(data));
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return HttpUserRepository(ref, http.Client());
});
