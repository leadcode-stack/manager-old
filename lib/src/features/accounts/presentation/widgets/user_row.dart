import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/utils/color.dart';
import 'package:manager/src/commons/widgets/dialogs/resource_delete_confirm_dialog.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/features/accounts/domain/controllers/user_controller.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';

class UserRow extends ConsumerWidget {
  final User user;

  const UserRow({required this.user, super.key});

  void handleDelete(BuildContext context, WidgetRef ref) {
    createResourceDeleteConfirmDialog(
        context: context,
        title: 'Delete user',
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Are you sure you want to delete ${user.firstname} ${user.lastname}?'),
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
              .read(userDeleteControllerProvider.notifier)
              .deleteUser(user.id);
          ref.watch(userUpdateControllerProvider).when(
              data: (_) => createSuccessToast(
                    context,
                    label: 'Success',
                    description: 'User has been deleted successfully.',
                  ),
              error: (error, stack) => createErrorToast(
                    context,
                    label: 'Error',
                    description: 'An error occurred while deleting the user.',
                  ),
              loading: () => {});
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text('${user.firstname} ${user.lastname}'),
        const SizedBox(width: 10),
        Row(
            children: user.roles
                .map((role) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Badge(
                          label: Text(role.name),
                          textColor: stringToColor(role.textColor),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          backgroundColor: stringToColor(role.backgroundColor)),
                    ))
                .toList()),
      ]),
      subtitle: Text(user.email,
          style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Image.network(
              width: 40,
              height: 40,
              'https://ui-avatars.com/api/?name=${user.firstname}+${user.lastname}',
              fit: BoxFit.cover)),
      onTap: () => context.go('/accounts/users/${user.id}/overview'),
    );
  }
}
