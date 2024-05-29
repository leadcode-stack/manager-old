import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination_controller.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/features/accounts/data/models/permission.dart';
import 'package:manager/src/features/accounts/data/repositories/permission_repository.dart';

final class PermissionsController
    extends AutoDisposeAsyncNotifier<Pagination<Permission>>
    with PaginationController<Permission> {
  @override
  Future<Pagination<Permission>> build() async {
    final params = Uri.base.queryParameters;
    final permissionRepository = ref.read(permissionRepositoryProvider);

    return permissionRepository.getPermissions(
      page: int.tryParse(params['page'] ?? '') ?? 1,
      limit: int.tryParse(params['limit'] ?? '') ?? 10,
    );
  }

  @override
  Future<Pagination<Permission>> paginate(int page, int limit) async {
    final permissionRepository = ref.read(permissionRepositoryProvider);

    return permissionRepository.getPermissions(
      page: page,
      limit: limit,
    );
  }
}

final permissionsController = AsyncNotifierProvider.autoDispose<
    PermissionsController, Pagination<Permission>>(PermissionsController.new);
