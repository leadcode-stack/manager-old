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
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    int getInitialIndex() => switch (location) {
          final path when path.startsWith('/accounts/users') => 0,
          final path when path.startsWith('/accounts/roles') => 1,
          _ => 0,
        };

    return Scaffold(
      appBar: const OverviewAppBar(
        title: 'Accounts',
        description: Text('Discover and manage users, roles and sessions.'),
      ),
      body: DefaultTabController(
        animationDuration: const Duration(milliseconds: 0),
        initialIndex: getInitialIndex(),
        length: 2,
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
                const Expanded(
                  child: TabBarView(
                      children: [UsersListScreen(), RolesListScreen()]),
                ),
              ],
            )),
      ),
    );
  }
}
