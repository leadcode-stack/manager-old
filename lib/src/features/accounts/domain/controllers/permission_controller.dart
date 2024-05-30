import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination_controller.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/commons/widgets/pagination/pagination.dart';
import 'package:manager/src/features/accounts/data/models/permission.dart';
import 'package:manager/src/features/accounts/data/repositories/permission_repository.dart';

final class PermissionsController
    extends AutoDisposeAsyncNotifier<Pagination<Permission>>
    with PaginationController<Permission> {
  @override
  Future<Pagination<Permission>> build() async {
    final permissionRepository = ref.read(permissionRepositoryProvider);
    return permissionRepository.getPermissions(null);
  }

  @override
  Future<Pagination<Permission>> paginate(PageSchema schema) async {
    final permissionRepository = ref.read(permissionRepositoryProvider);
    return permissionRepository.getPermissions(schema);
  }
}

final permissionsController = AsyncNotifierProvider.autoDispose<
    PermissionsController, Pagination<Permission>>(PermissionsController.new);
