import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/routing/scaffold_nested_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Center(child: Text('Home')),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'accounts'),
          routes: [
            GoRoute(
              path: '/accounts/overview',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Center(child: Text('Account Overview')),
              ),
            ),
            GoRoute(
              path: '/accounts/users',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Center(child: Text('Users Overview')),
              ),
              routes: [
                GoRoute(
                    path: ':id/overview',
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: Center(child: Text('User profil')))),
              ],
            ),
          ],
        )
      ],
    ),
  ],
);
