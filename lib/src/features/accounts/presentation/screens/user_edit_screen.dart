import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/accounts/data/controllers/user_controller.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/presentation/screens/user_profile_screen.dart';

final class UsersEditScreen extends ConsumerStatefulWidget {
  final int id;

  const UsersEditScreen({required this.id, super.key});

  @override
  ConsumerState<UsersEditScreen> createState() => _UsersEditScreenState();
}

class _UsersEditScreenState extends ConsumerState<UsersEditScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userControllerProvider(widget.id));

    return state.when(
      error: (e, __) => Center(child: Text(e.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (User user) => Scaffold(
          appBar: OverviewAppBar(
            title: user.username,
            description:
                const Text('Discover and manage user, roles and sessions.'),
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
                          Tab(text: 'Profile'),
                          Tab(text: 'Roles'),
                          Tab(text: 'Articles'),
                          Tab(text: 'Preferences'),
                          Tab(text: 'Sessions'),
                          Tab(
                              child: Text(
                            'Danger zone',
                            style: TextStyle(color: Colors.red),
                          )),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      UserProfileScreen(user: user),
                      const Center(
                        child: Text('Current Roles'),
                      ),
                      const Center(
                        child: Text('Articles'),
                      ),
                      const Center(
                        child: Text('Preferences'),
                      ),
                      const Center(
                        child: Text('Sessions'),
                      ),
                      const Center(
                        child: Text('Danger zone'),
                      ),
                    ]),
                  ),
                ],
              ))),
    );
  }
}
