import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/app.dart';
import 'package:manager/src/commons/widgets/app_startup/app_startup_error.dart';
import 'package:manager/src/commons/widgets/app_startup/app_startup_loading.dart';
import 'package:manager/src/features/authentication/domains/controllers/auth_controller.dart';

class AppStartup extends ConsumerStatefulWidget {
  const AppStartup({super.key});

  @override
  ConsumerState<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends ConsumerState<AppStartup> {
  @override
  Widget build(BuildContext context) {
    final appStartupState = ref.watch(appStartupProvider);

    return appStartupState.when(
        data: (_) => const MyApp(),
        error: (e, st) => AppStartupError(
              message: e.toString(),
              onRetry: () => ref.invalidate(appStartupProvider),
            ),
        loading: () => const AppStartupLoadingWidget());
  }
}

final appStartupProvider = FutureProvider((ref) async {
  final authController = ref.read(authControllerProvider.notifier);
  await authController.load();
});
