import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/accounts/presentation/screens/roles/roles_list_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/users/users_list_screen.dart';

class AccountOverviewScreen extends StatefulWidget {
  /// Creates a RootScreen
  const AccountOverviewScreen({super.key});

  @override
  State<AccountOverviewScreen> createState() => _AccountOverviewScreenState();
}

class _AccountOverviewScreenState extends State<AccountOverviewScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).path;
    _tabController.index = switch (location) {
      final location when location!.startsWith('/accounts/users') => 0,
      final location when location!.startsWith('/accounts/roles') => 1,
      _ => 0,
    };

    return Scaffold(
      appBar: const OverviewAppBar(
        title: 'Accounts',
        description: Text('Discover and manage users, roles and sessions.'),
      ),
      body: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelColor: Colors.blue.shade400,
                    indicatorColor: Colors.blue.shade400,
                    dividerColor: Colors.grey.shade200,
                    onTap: (index) {
                      return switch (index) {
                        0 => context.go('/accounts/users'),
                        1 => context.go('/accounts/roles'),
                        _ => null,
                      };
                    },
                    tabs: const [
                      Tab(text: 'Members'),
                      Tab(text: 'Roles'),
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: const [
                  UsersListScreen(),
                  RolesListScreen()
                ]),
              ),
            ],
          )),
    );
  }
}
