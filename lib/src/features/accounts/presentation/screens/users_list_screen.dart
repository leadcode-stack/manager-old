import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination.dart';
import 'package:manager/src/features/accounts/domain/controllers/user_controller.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/presentation/widgets/user_row.dart';

final class UsersListScreen extends ConsumerWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Pagination<User>> state = ref.watch(usersControllerProvider);

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            color: Colors.grey.shade200,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                  color: Colors.white,
                ),
                child: state.when(
                    data: (pagination) => ListView.builder(
                          itemCount: pagination.data.length,
                          itemBuilder: (context, index) {
                            final user = pagination.data[index];
                            return UserRow(user: user);
                          },
                        ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text(e.toString())))));
  }
}
