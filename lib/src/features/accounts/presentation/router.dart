import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/pagination/pagination.dart';
import 'package:manager/src/features/accounts/presentation/screens/account_overview_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/roles/role_overview_screen.dart';
import 'package:manager/src/features/accounts/presentation/screens/users/user_overview_screen.dart';

final userOverviewLinks = [
  'overview',
  'roles',
  'articles',
  'preferences',
  'sessions',
  'danger-zone'
];

final roleOverviewLinks = ['overview', 'permissions', 'danger-zone'];

StatefulShellBranch router = StatefulShellBranch(
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
                      pageSchema: PageSchema.of(Uri.base),
                      id: int.parse(state.pathParameters['id']!))),
            ),
        ]),
  ],
);
