import 'package:flutter/material.dart';

final class FloatingSubmitButton extends StatelessWidget {
  final void Function() onPressed;
  final bool loading;

  const FloatingSubmitButton({
    required this.onPressed,
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blue.shade300,
      child: loading
          ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
          : const Icon(Icons.save, color: Colors.white),
    );
  }
}