import 'package:go_router/go_router.dart';
import 'package:manager/src/features/authentication/presentation/login_screen.dart';

final router = GoRoute(
  path: '/authentication/login',
  pageBuilder: (context, state) =>
  const NoTransitionPage(
    child: LoginScreen(),
  ),
);