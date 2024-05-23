import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/data/repositories/user_repository.dart';

final class UsersController extends AutoDisposeAsyncNotifier<Pagination<User>> {
  @override
  Future<Pagination<User>> build() {
    final userRepository = ref.read(userRepositoryProvider);
    return userRepository.getUsers();
  }
}

final class UserController extends AutoDisposeFamilyAsyncNotifier<User, int> {
  @override
  FutureOr<User> build(int arg) {
    final userRepository = ref.read(userRepositoryProvider);
    return userRepository.getUser(this.arg);
  }
}

final class UserUpdateController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> updateUser(int id, Map<String, dynamic> payload) async {
    final userRepository = ref.read(userRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => userRepository.update(id, payload),
    );
  }
}

final class UserDeleteController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  FutureOr<void> deleteUser(int id) async {
    final userRepository = ref.read(userRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => userRepository.delete(id),
    );
  }
}

final usersControllerProvider =
    AsyncNotifierProvider.autoDispose<UsersController, Pagination<User>>(
        UsersController.new);

final userControllerProvider = AsyncNotifierProvider.autoDispose
    .family<UserController, User, int>(UserController.new);

final userUpdateControllerProvider =
    AsyncNotifierProvider<UserUpdateController, void>(UserUpdateController.new);

final userDeleteControllerProvider =
    AsyncNotifierProvider<UserDeleteController, void>(UserDeleteController.new);
