import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/features/accounts/domain/controllers/user_controller.dart';

final class UserProfileRolesPanel extends ConsumerStatefulWidget {
  final User user;

  const UserProfileRolesPanel({required this.user, super.key});

  @override
  ConsumerState<UserProfileRolesPanel> createState() =>
      _UserProfileRolesPanelState();
}

final class _UserProfileRolesPanelState
    extends ConsumerState<UserProfileRolesPanel> {
  Future<void> handleChangeRole(Role role, bool value) async {
    final userRoleIds = widget.user.roles.map((role) => role.id).toList();
    final payload = {
      'roles': value
          ? [...userRoleIds, role.id]
          : userRoleIds.where((id) => id != role.id).toList(),
    };

    await ref
        .read(userUpdateControllerProvider.notifier)
        .updateUser(widget.user.id, payload);

    ref.watch(userUpdateControllerProvider).when(
          data: (_) {
            ref.invalidate(usersControllerProvider);
            ref.invalidate(userControllerProvider(widget.user.id));

            createSuccessToast(
              context,
              description: 'User roles have been updated successfully.',
            );
          },
          error: (error, stack) {
            createErrorToast(
              context,
              description: 'An error occurred while updating user roles.',
            );
          },
          loading: () => {},
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rolesControllerProvider);
    final userRoleIds = widget.user.roles.map((role) => role.id).toList();

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        return const Center(child: Text('error'));
      },
      data: (roles) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current roles',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: roles.data.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1.0, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final role = roles.data[index];
                  return CheckboxListTile(
                    title: Text(role.name),
                    subtitle: Text(role.description ?? ''),
                    value: userRoleIds.contains(role.id),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) =>
                        handleChangeRole(role, value!),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
