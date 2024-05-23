import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/app_startup/app_startup.dart';
import 'package:manager/src/commons/widgets/routing/scaffold_nested_navigation.dart';
import 'package:manager/src/constants/routes.dart';
import 'package:manager/src/features/accounts/presentation/screens/account_overview_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/role_overview_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/user_overview_screen.dart';
import 'package:manager/src/features/authentication/data/models/auth.dart';
import 'package:manager/src/features/authentication/presentation/login_screen.dart';
import 'package:manager/src/features/overview/presentation/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(WidgetRef ref) {
  final appStartupState = ref.watch(appStartupProvider);
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/authentication/login',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/startup';
      }

      if (auth.isLoggedIn && state.fullPath == '/authentication/login') {
        return '/';
      }

      if (!auth.isLoggedIn && state.fullPath != '/authentication/login') {
        return '/authentication/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AppStartup(),
        ),
      ),
      GoRoute(
        path: '/authentication/login',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
            child:
                ScaffoldWithNestedNavigation(navigationShell: navigationShell)),
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'accounts'),
            routes: [
              GoRoute(
                  path: '/accounts/users',
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: AccountOverviewScreen(),
                      ),
                  routes: [
                    for (final location in userOverviewLinks)
                      GoRoute(
                        path: ':id/$location',
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: UserOverviewScreen(
                                id: int.parse(state.pathParameters['id']!))),
                      ),
                  ]),
              GoRoute(
                  path: '/accounts/roles',
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: AccountOverviewScreen(),
                      ),
                  routes: [
                    for (final location in roleOverviewLinks)
                      GoRoute(
                        path: ':id/$location',
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: RoleOverviewScreen(
                                id: int.parse(state.pathParameters['id']!))),
                      ),
                  ]),
            ],
          ),
        ],
      ),
    ],
  );
}
