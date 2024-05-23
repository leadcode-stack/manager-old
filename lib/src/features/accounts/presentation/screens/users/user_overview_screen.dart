import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/accounts/domain/controllers/user_controller.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/presentation/screens/users/user_profile_screen.dart';
import 'package:manager/src/features/authentication/data/models/auth.dart';

final class UserOverviewScreen extends ConsumerStatefulWidget {
  final int id;

  const UserOverviewScreen({required this.id, super.key});

  @override
  ConsumerState<UserOverviewScreen> createState() => _UserOverviewScreenState();
}

class _UserOverviewScreenState extends ConsumerState<UserOverviewScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final state = ref.watch(userControllerProvider(widget.id));

    int getInitialIndex(User user) => switch (GoRouterState.of(context).matchedLocation) {
      final path when path.startsWith('/accounts/users/${user.id}/overview') => 0,
      final path when path.startsWith('/accounts/users/${user.id}/roles') => 1,
      final path when path.startsWith('/accounts/users/${user.id}/articles') => 2,
      final path when path.startsWith('/accounts/users/${user.id}/preferences') => 3,
      final path when path.startsWith('/accounts/users/${user.id}/sessions') => 4,
      final path when (auth.user?.id != user.id) && path.startsWith('/accounts/users/${user.id}/danger-zone') => 5,
      _ => 0,
    };

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
            initialIndex: getInitialIndex(user),
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
                          onTap: (index) {
                            return switch (index) {
                              0 => context.go('/accounts/users/${user.id}/overview'),
                              1 => context.go('/accounts/users/${user.id}/roles'),
                              2 => context.go('/accounts/users/${user.id}/articles'),
                              3 => context.go('/accounts/users/${user.id}/preferences'),
                              4 => context.go('/accounts/users/${user.id}/sessions'),
                              5 => context.go('/accounts/users/${user.id}/danger-zone'),
                              _ => 0,
                            };
                          },
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
