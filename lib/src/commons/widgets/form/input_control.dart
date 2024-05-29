import 'package:flutter/material.dart';

final class InputControl extends StatelessWidget {
  final String label;
  final String? initialValue;
  final GlobalKey<FormState> formKey;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final double? width;

  const InputControl(
      {required this.formKey,
      required this.label,
      this.initialValue,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      width: width,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 300),
        child: IntrinsicWidth(
          child: TextFormField(
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(fontSize: 14.0),
            decoration: InputDecoration(
                labelText: label,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
          ),
        ),
      ),
    );
  }
}
