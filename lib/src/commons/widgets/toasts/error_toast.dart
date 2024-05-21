import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void createErrorToast(BuildContext context,
        {required String label,
        String? description,
        Duration? duration = const Duration(seconds: 5)}) =>
    toastification.show(
        context: context,
        title: Text(label),
        style: ToastificationStyle.flat,
        autoCloseDuration: duration,
        alignment: Alignment.topRight,
        description: description != null
            ? RichText(text: TextSpan(text: description))
            : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 16,
            offset: Offset(0, 16),
            spreadRadius: 0,
          )
        ],
        type: ToastificationType.error);
