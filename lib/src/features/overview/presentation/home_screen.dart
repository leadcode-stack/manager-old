import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/resource_bars/overview_app_bar.dart';

class HomeScreen extends StatelessWidget {
  /// Creates a RootScreen
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OverviewAppBar(
        title: 'Welcome',
        description: Text('dd'),
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
