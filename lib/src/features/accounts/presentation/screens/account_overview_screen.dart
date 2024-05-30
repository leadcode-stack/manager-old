import 'package:flutter/material.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/commons/widgets/ui/resource_tab_layout.dart';
import 'package:manager/src/features/accounts/presentation/screens/roles/roles_list_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/users/users_list_screen.dart';

class AccountOverviewScreen extends StatelessWidget {
  const AccountOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: OverviewAppBar(
          title: 'Accounts',
          description: Text('Discover and manage users, roles and sessions.'),
        ),
        body: ResourceTabLayout(
          resources: [
            ResourceTab(
                label: Text('Members'),
                path: '/accounts/users',
                child: UsersListScreen()),
            ResourceTab(
                label: Text('Roles'),
                path: '/accounts/roles',
                child: RolesListScreen()),
          ],
        ));
  }
}
