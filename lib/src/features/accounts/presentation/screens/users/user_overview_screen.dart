import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/commons/widgets/ui/resource_tab_layout.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/domain/controllers/user_controller.dart';
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
            body: ResourceTabLayout(
              resources: [
                ResourceTab(
                    label: const Text('Overview'),
                    path: '/accounts/users/${user.id}/overview',
                    child: UserProfileScreen(user: user)),
                ResourceTab(
                    label: const Text('Articles'),
                    path: '/accounts/users/${user.id}/articles',
                    child: const Center(
                      child: Text('Articles'),
                    )),
                ResourceTab(
                    label: const Text('Preferences'),
                    path: '/accounts/users/${user.id}/preferences',
                    child: const Center(
                      child: Text('Preferences'),
                    )),
                ResourceTab(
                    label: const Text('Sessions'),
                    path: '/accounts/users/${user.id}/sessions',
                    child: const Center(
                      child: Text('Sessions'),
                    )),
                ResourceTab(
                    label: const Text('Danger zone',
                        style: TextStyle(color: Colors.red)),
                    path: '/accounts/users/${user.id}/danger-zone',
                    visible: user.id != auth.user?.id,
                    child: const Center(
                      child: Text('Danger zone'),
                    )),
              ],
            )));
  }
}
