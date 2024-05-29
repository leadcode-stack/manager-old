import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:manager/src/application/preferences/shared_preferences.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/constants/http.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';

abstract interface class RoleRepository {
  Future<Pagination<Role>> getRoles();

  Future<Role> getRole(int id);

  Future<Role> create(Map<String, dynamic> payload);

  Future<Role> update(int id, Map<String, dynamic> payload);

  Future<void> delete(int id);
}

final class HttpRoleRepository implements RoleRepository {
  final ProviderRef _ref;
  final http.Client _client;

  HttpRoleRepository(this._ref, this._client);

  @override
  Future<Pagination<Role>> getRoles() async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .get(Uri.parse('$baseApiUrl/roles'),
            headers: {'Authorization': 'Bearer $token'})
        .then((response) => jsonDecode(response.body))
        .then((data) => Pagination.of(data, Role.fromJson));
  }

  @override
  Future<Role> getRole(int id) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .get(Uri.parse('$baseApiUrl/roles/$id'),
            headers: {'Authorization': 'Bearer $token'})
        .then((response) => jsonDecode(response.body))
        .then((data) => Role.fromJson(data));
  }

  @override
  Future<Role> create(Map<String, dynamic> payload) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .post(Uri.parse('$baseApiUrl/roles'),
            body: jsonEncode(payload),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            })
        .then((response) => jsonDecode(response.body))
        .then((data) => Role.fromJson(data));
  }

  @override
  Future<Role> update(int id, Map<String, dynamic> payload) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .put(Uri.parse('$baseApiUrl/roles/$id'),
            body: jsonEncode(payload),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            })
        .then((response) => jsonDecode(response.body))
        .then((data) => Role.fromJson(data));
  }

  @override
  Future<void> delete(int id) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    await _client.delete(Uri.parse('$baseApiUrl/roles/$id'),
        headers: {'Authorization': 'Bearer $token'});
  }
}

final roleRepositoryProvider = Provider<RoleRepository>((ref) {
  return HttpRoleRepository(ref, http.Client());
});
