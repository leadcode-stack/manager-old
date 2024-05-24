import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/data/repositories/role_repository.dart';

final class RolesController extends AutoDisposeAsyncNotifier<Pagination<Role>> {
  @override
  Future<Pagination<Role>> build() {
    final roleRepository = ref.read(roleRepositoryProvider);
    return roleRepository.getRoles();
  }
}

final class RoleController extends AutoDisposeFamilyAsyncNotifier<Role, int> {
  @override
  FutureOr<Role> build(int arg) {
    final roleRepository = ref.read(roleRepositoryProvider);
    return roleRepository.getRole(this.arg);
  }
}

final class RoleCreateController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> createRole(Map<String, dynamic> payload) async {
    final roleRepository = ref.read(roleRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => roleRepository.create(payload),
    );
  }
}

final class RoleUpdateController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> updateRole(int id, Map<String, dynamic> payload) async {
    final roleRepository = ref.read(roleRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => roleRepository.update(id, payload),
    );
  }
}

final class RoleDeleteController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  FutureOr<void> deleteRole(int id) async {
    final roleRepository = ref.read(roleRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => roleRepository.delete(id),
    );
  }
}

final rolesControllerProvider =
    AsyncNotifierProvider.autoDispose<RolesController, Pagination<Role>>(
        RolesController.new);

final roleControllerProvider = AsyncNotifierProvider.autoDispose
    .family<RoleController, Role, int>(RoleController.new);

final roleStoreControllerProvider =
AsyncNotifierProvider<RoleCreateController, void>(RoleCreateController.new);

final roleUpdateControllerProvider =
    AsyncNotifierProvider<RoleUpdateController, void>(RoleUpdateController.new);

final roleDeleteControllerProvider =
    AsyncNotifierProvider<RoleDeleteController, void>(RoleDeleteController.new);
