import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/pagination/pagination.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/commons/widgets/ui/resource_tab_layout.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/features/accounts/presentation/screens/roles/role_edit_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/roles/role_permissions_screen.dart';

final class RoleOverviewScreen extends ConsumerWidget {
  final PageSchema pageSchema;
  final int id;

  const RoleOverviewScreen(
      {required this.pageSchema, required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(roleControllerProvider(id));

    return state.when(
      error: (e, _) => Center(child: Text(e.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (Role role) => Scaffold(
          appBar: OverviewAppBar(
            title: role.name,
            description:
                const Text('Discover and manage user, roles and sessions.'),
          ),
          body: ResourceTabLayout(
            resources: [
              ResourceTab(
                  label: const Text('Overview'),
                  path: '/accounts/roles/${role.id}/overview',
                  child: RoleEditScreen(role: role)),
              ResourceTab(
                  label: const Text('Permissions'),
                  path: '/accounts/roles/${role.id}/permissions',
                  child: RolePermissionsScreen(
                      pageSchema: pageSchema, role: role)),
              ResourceTab(
                  label: const Text('Danger zone'),
                  path: '/accounts/roles/${role.id}/danger-zone',
                  child: const Center(
                    child: Text('Danger zone'),
                  )),
            ],
          )),
    );
  }
}
