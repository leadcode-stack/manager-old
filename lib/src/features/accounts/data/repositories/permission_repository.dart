import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:manager/src/application/preferences/shared_preferences.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/commons/widgets/pagination/pagination.dart';
import 'package:manager/src/constants/http.dart';
import 'package:manager/src/features/accounts/data/models/permission.dart';

abstract interface class PermissionRepository {
  Future<Pagination<Permission>> getPermissions(PageSchema? schema);
}

final class HttpPermissionRepository implements PermissionRepository {
  final ProviderRef _ref;
  final http.Client _client;

  HttpPermissionRepository(this._ref, this._client);

  @override
  Future<Pagination<Permission>> getPermissions(PageSchema? schema) async {
    final preferences = _ref.read(sharedPreferencesProvider);
    final token = preferences.getString('token');

    final params = {
      if (schema?.page != null) 'page': schema?.page.toString(),
      if (schema?.limit != null) 'limit': schema!.limit.toString(),
      if (schema?.search != null) 'search': schema!.search,
    };

    final uri = Uri(path: 'permissions', queryParameters: params);

    return _client
        .get(Uri.parse('$baseApiUrl/$uri'),
            headers: {'Authorization': 'Bearer $token'})
        .then((response) => jsonDecode(response.body))
        .then((data) => Pagination.of(data, Permission.fromJson));

  }
}

final permissionRepositoryProvider = Provider<PermissionRepository>((ref) {
  return HttpPermissionRepository(ref, http.Client());
});
