import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/features/accounts/presentation/screens/roles/role_edit_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/roles/role_permissions_screen.dart';

final class RoleOverviewScreen extends ConsumerStatefulWidget {
  final int id;

  const RoleOverviewScreen({required this.id, super.key});

  @override
  ConsumerState<RoleOverviewScreen> createState() => _RoleOverviewScreenState();
}

class _RoleOverviewScreenState extends ConsumerState<RoleOverviewScreen>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(roleControllerProvider(widget.id));

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
          body: DefaultTabController(
            initialIndex: switch(GoRouterState.of(context).matchedLocation) {
              final path when path.startsWith('/accounts/roles/${role.id}/overview') => 0,
              final path when path.startsWith('/accounts/roles/${role.id}/permissions') => 1,
              final path when path.startsWith('/accounts/roles/${role.id}/danger-zone') => 2,
              _ => 0,
            },
            length: 3,
            child: Container(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: TabBar(
                          isScrollable: true,
                          labelColor: Colors.blue.shade400,
                          indicatorColor: Colors.blue.shade400,
                          dividerColor: Colors.grey.shade200,
                          onTap: (index) {
                            return switch (index) {
                              0 => context.go('/accounts/roles/${role.id}/overview'),
                              1 => context.go('/accounts/roles/${role.id}/permissions?page=1&limit=10'),
                              2 => context.go('/accounts/roles/${role.id}/danger-zone'),
                              _ => 0,
                            };
                          },
                          tabs: const [
                            Tab(text: 'Overview'),
                            Tab(text: 'Permissions'),
                            Tab(
                                child: Text(
                              'Danger zone',
                              style: TextStyle(color: Colors.red),
                            )),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        RoleEditScreen(role: role),
                        RolePermissionsScreen(role: role),
                        const Center(
                          child: Text('Danger zone'),
                        ),
                      ]),
                    ),
                  ],
                )),
          )),
    );
  }
}
