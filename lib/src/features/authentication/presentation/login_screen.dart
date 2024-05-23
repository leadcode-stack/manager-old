import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manager/src/commons/widgets/form/input_control.dart';
import 'package:manager/src/features/authentication/domains/controllers/auth_controller.dart';
import 'package:manager/src/features/authentication/domains/validators/auth_validator.dart';

final class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = 'baptiste.parmantier.pro@gmail.com';
  String _password = '486279315Aa?';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Container(
                    color: Colors.blue,
                    width: size.width / 3,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputControl(
                          formKey: _formKey,
                          label: 'Email',
                          validator: validateEmail,
                          initialValue: _email,
                          onSaved: (value) => _email = value!),
                      const SizedBox(height: 8.0),
                      InputControl(
                          formKey: _formKey,
                          label: 'Password',
                          validator: validatePassword,
                          initialValue: _password,
                          onSaved: (value) => _password = value!),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              final authController =
                                  ref.read(authControllerProvider.notifier);
                              await authController.login(_email, _password);

                              if (context.mounted) {
                                context.go('/');
                              }
                            }
                          },
                          child: const Text('Login'))
                    ],
                  ))
                ],
              ),
            )));
  }
}
