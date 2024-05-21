import 'package:flutter/material.dart';

final class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
