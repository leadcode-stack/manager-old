import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/dialogs/resource_delete_confirm_dialog.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';

class UserRow extends StatelessWidget {
  final User user;

  const UserRow({required this.user, super.key});

  void handleDelete(context) {
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
        onPressed: () {
          print('cc');
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text('${user.firstname} ${user.lastname}'),
        const SizedBox(width: 10),
        Row(
            children: user.roles
                .map((role) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(role.name,
                        style: const TextStyle(color: Colors.blue, fontSize: 12.0))))
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
      trailing: PopupMenuButton<int>(
        tooltip: '',
        color: Colors.white,
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () => context.go('/accounts/users/${user.id}/overview'),
            child: const Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () => handleDelete(context),
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
