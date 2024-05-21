import 'package:flutter/material.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/accounts/presentation/screens/users_list_screen.dart';

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
                    tabs: const [
                      Tab(text: 'Members'),
                      Tab(text: 'Roles'),
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: const [
                  UsersListScreen(),
                  Center(
                    child: Text('CC 2'),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
