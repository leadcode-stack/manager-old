import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:manager/src/application/preferences/shared_preferences.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/constants/http.dart';
import 'package:manager/src/features/accounts/data/models/permission.dart';

abstract interface class PermissionRepository {
  Future<Pagination<Permission>> getPermissions({int page = 1, int limit = 10});
}

final class HttpPermissionRepository implements PermissionRepository {
  final ProviderRef _ref;
  final http.Client _client;

  HttpPermissionRepository(this._ref, this._client);

  @override
  Future<Pagination<Permission>> getPermissions(
      {int page = 1, int limit = 10}) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    return _client
        .get(Uri.parse('$baseApiUrl/permissions?page=$page&limit=$limit'),
            headers: {'Authorization': 'Bearer $token'})
        .then((response) => jsonDecode(response.body))
        .then((data) => Pagination.of(data, Permission.fromJson));
  }
}

final permissionRepositoryProvider = Provider<PermissionRepository>((ref) {
  return HttpPermissionRepository(ref, http.Client());
});
