import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/features/overview/presentation/home_screen.dart';

final StatefulShellBranch router = StatefulShellBranch(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: HomeScreen(),
      ),
    ),
  ],
);