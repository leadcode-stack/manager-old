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

final usersControllerProvider = AsyncNotifierProvider.autoDispose<UsersController, Pagination<User>>(UsersController.new);
final userControllerProvider = AsyncNotifierProvider.autoDispose.family<UserController, User, int>(UserController.new);