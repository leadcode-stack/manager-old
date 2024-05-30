import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/frame.dart';
import 'package:manager/src/commons/widgets/pagination/pagination.dart';
import 'package:manager/src/commons/widgets/pagination/search_bar.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/data/models/permission.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/domain/controllers/permission_controller.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';

final class RolePermissionsScreen extends ConsumerStatefulWidget {
  final PageSchema pageSchema;
  final Role role;

  const RolePermissionsScreen(
      {required this.pageSchema, required this.role, super.key});

  @override
  ConsumerState<RolePermissionsScreen> createState() =>
      _RolePermissionsScreenState();
}

class _RolePermissionsScreenState extends ConsumerState<RolePermissionsScreen> {
  Future<void> handleChangePermission(Permission permission, bool value) async {
    final rolePermissionIds =
        widget.role.permissions.map((permission) => permission.id).toList();
    final payload = {
      'permissions': value
          ? [...rolePermissionIds, permission.id]
          : rolePermissionIds.where((id) => id != permission.id).toList(),
    };

    await ref
        .read(roleUpdateControllerProvider.notifier)
        .updateRole(widget.role.id, payload);

    ref.watch(roleUpdateControllerProvider).when(
          data: (_) {
            ref.invalidate(rolesControllerProvider);
            ref.invalidate(roleControllerProvider(widget.role.id));

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
    final state = ref.watch(permissionsController);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(stack.toString())),
      data: (permissions) {
        return Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(16.0),
          child: Frame(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeading(),
                _buildBody(permissions.data),
                PaginationNavigator<Permission>(
                  pagination: permissions,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeading() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Permissions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Search(notifier: permissionsController.notifier)
      ],
    );
  }

  Widget _buildBody(List<Permission> permissions) {
    final rolePermissionIds =
        widget.role.permissions.map((permission) => permission.id).toList();

    return Expanded(
      child: ListView.separated(
        itemCount: permissions.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1.0, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final permission = permissions[index];
          return CheckboxListTile(
            title: Text(permission.name),
            subtitle: Text(permission.description ?? ''),
            value: rolePermissionIds.contains(permission.id),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) =>
                handleChangePermission(permission, value!),
          );
        },
      ),
    );
  }
}
