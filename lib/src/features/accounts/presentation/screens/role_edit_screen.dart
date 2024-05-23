import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/features/accounts/presentation/screens/role_overview_screen.dart';

final class RoleEditScreen extends ConsumerStatefulWidget {
  final int id;

  const RoleEditScreen({required this.id, super.key});

  @override
  ConsumerState<RoleEditScreen> createState() => _RoleEditScreenState();
}

class _RoleEditScreenState extends ConsumerState<RoleEditScreen>
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
            initialIndex: 0,
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
                        RoleOverviewScreen(role: role),
                        const Center(
                          child: Text('Edit permission'),
                        ),
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
