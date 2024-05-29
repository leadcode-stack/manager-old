import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/form/input_control.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/domain/controllers/user_controller.dart';
import 'package:manager/src/features/accounts/domain/validators/user_validators.dart';

final class UserProfileIdentityPanel extends ConsumerStatefulWidget {
  final User user;

  const UserProfileIdentityPanel({required this.user, super.key});

  @override
  ConsumerState<UserProfileIdentityPanel> createState() =>
      _UserProfileIdentityPanelState();
}

final class _UserProfileIdentityPanelState
    extends ConsumerState<UserProfileIdentityPanel> {
  final _formKey = GlobalKey<FormState>();

  late String _firstName;
  late String _lastName;
  late String _email;

  @override
  void initState() {
    super.initState();
    _firstName = widget.user.firstname;
    _lastName = widget.user.lastname;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Identity',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20.0),
          InputControl(
              formKey: _formKey,
              label: 'Firstname',
              width: double.infinity,
              initialValue: widget.user.firstname,
              validator: validateFirstname,
              onSaved: (value) => _firstName = value!),
          const SizedBox(height: 8.0),
          InputControl(
              formKey: _formKey,
              label: 'Lastname',
              width: double.infinity,
              initialValue: widget.user.lastname,
              validator: validateLastname,
              onSaved: (value) => _lastName = value!),
          const SizedBox(height: 8.0),
          InputControl(
              formKey: _formKey,
              label: 'Email',
              width: double.infinity,
              initialValue: widget.user.email,
              validator: validateEmail,
              onSaved: (value) => _email = value!),
          ElevatedButton(
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0.0),
            ),
            child: const Text('Update'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                await ref
                    .read(userUpdateControllerProvider.notifier)
                    .updateUser(widget.user.id, {
                  'firstname': _firstName,
                  'lastname': _lastName,
                  'email': _email
                });

                ref.watch(userUpdateControllerProvider).when(
                    loading: () => {},
                    error: (error, stack) {
                      createErrorToast(
                        context,
                        label: 'Error',
                        description:
                        'An error occurred while updating the user.',
                      );
                    },
                    data: (_) {
                      createSuccessToast(
                        context,
                        label: 'Success',
                        description: 'User has been updated successfully.',
                      );
                    }); // Ajout d'une virgule ici
              }
            }, // Ajout d'une parenthèse fermante ici
          )
        ],
      ),
    ); // Ajout d'une accolade fermante ici
  }
}
