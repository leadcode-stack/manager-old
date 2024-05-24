import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/dialogs/resource_delete_confirm_dialog.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';

class RoleRow extends ConsumerWidget {
  final Role role;

  const RoleRow({required this.role, super.key});

  void handleDelete(BuildContext context, WidgetRef ref) {
    createResourceDeleteConfirmDialog(
        context: context,
        title: 'Delete role',
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to delete ${role.name}?'),
            const SizedBox(height: 16),
            const Text('This action cannot be undone.'),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://media1.tenor.com/m/sLgNruA4tsgAAAAC/warning-lights.gif',
              ),
            )
          ],
        ),
        onPressed: () async {
          await ref
              .read(roleDeleteControllerProvider.notifier)
              .deleteRole(role.id);

          ref.watch(roleDeleteControllerProvider).when(
              data: (_) {
                ref.invalidate(rolesControllerProvider);
                createSuccessToast(
                  context,
                  label: 'Success',
                  description: 'Role has been deleted successfully.',
                );
              },
              error: (error, stack) {
                createErrorToast(
                  context,
                  label: 'Error',
                  description: 'An error occurred while deleting the role.',
                );
              },
              loading: () => {});
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(role.name),
        const SizedBox(width: 10),
        Container(
          width: 15.0,
          height: 15.0,
          decoration: BoxDecoration(
            color:
            Color(int.parse('0xFF${role.textColor.replaceFirst('#', '')}')),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 15.0,
          height: 15.0,
          decoration: BoxDecoration(
            color: Color(
                int.parse('0xFF${role.backgroundColor.replaceFirst('#', '')}')),
            shape: BoxShape.circle,
          ),
        ),
      ]),
      subtitle: Text('${role.permissions.length} permissions',
          style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
      trailing: PopupMenuButton<int>(
        tooltip: '',
        color: Colors.white,
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) =>
        [
          PopupMenuItem(
            onTap: () => context.go('/accounts/roles/${role.id}/overview'),
            child: const Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () => handleDelete(context, ref),
            child: const Row(
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(width: 8),
                Text('Delete'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
