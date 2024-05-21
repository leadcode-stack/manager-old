import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';
import 'package:manager/src/features/authentication/data/models/auth.dart';

class HomeScreen extends ConsumerWidget {
  /// Creates a RootScreen
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: OverviewAppBar(
        title: 'Welcome',
        description: Text('${auth.user?.username} + ${auth.token?.value}'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go('/accounts/overview/details'),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}
