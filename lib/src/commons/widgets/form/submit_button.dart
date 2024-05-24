import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class SubmitButton extends ConsumerWidget {
  final String label;
  final void Function() onPressed;
  final bool loading;

  const SubmitButton({
    required this.label,
    required this.onPressed,
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.blue.shade300,
        ),
        onPressed: onPressed,
        child: loading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white))
            : Text(label, style: const TextStyle(color: Colors.white)));
  }
}
