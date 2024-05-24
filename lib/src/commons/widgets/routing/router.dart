import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/app_startup/app_startup.dart';
import 'package:manager/src/commons/widgets/routing/scaffold_nested_navigation.dart';
import 'package:manager/src/features/authentication/data/models/auth.dart';
import 'package:manager/src/features/accounts/presentation/router.dart'
    as account;
import 'package:manager/src/features/authentication/presentation/router.dart'
    as authentication;
import 'package:manager/src/features/overview/presentation/router.dart'
    as overview;

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
      authentication.router,
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
            child:
                ScaffoldWithNestedNavigation(navigationShell: navigationShell)),
        branches: [overview.router, account.router],
      ),
    ],
  );
}
