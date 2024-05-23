import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/accounts/domains/controllers/user_controller.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/presentation/screens/user_profile_screen.dart';
import 'package:manager/src/features/authentication/data/models/auth.dart';

final class UsersEditScreen extends ConsumerStatefulWidget {
  final int id;

  const UsersEditScreen({required this.id, super.key});

  @override
  ConsumerState<UsersEditScreen> createState() => _UsersEditScreenState();
}

class _UsersEditScreenState extends ConsumerState<UsersEditScreen>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
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
          body: DefaultTabController(
            initialIndex: 0,
            length: user.id != auth.user?.id ? 6 : 5,
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
                          tabs: [
                            const Tab(text: 'Profile'),
                            const Tab(text: 'Roles'),
                            const Tab(text: 'Articles'),
                            const Tab(text: 'Preferences'),
                            const Tab(text: 'Sessions'),
                            if (user.id != auth.user?.id)
                            const Tab(
                                child: Text(
                              'Danger zone',
                              style: TextStyle(color: Colors.red),
                            )),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(children: [
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
                        if (user.id != auth.user?.id)
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
