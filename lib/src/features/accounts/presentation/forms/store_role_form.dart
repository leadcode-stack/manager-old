import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/form/input_color.dart';
import 'package:manager/src/commons/widgets/form/input_control.dart';
import 'package:manager/src/commons/widgets/form/submit_button.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/features/accounts/domain/validators/role_validators.dart';

final class StoreRoleForm extends ConsumerStatefulWidget {
  const StoreRoleForm({super.key});

  @override
  ConsumerState<StoreRoleForm> createState() => _RoleFormState();
}

class _RoleFormState extends ConsumerState<StoreRoleForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String? _description = '';
  String _textColor = 'FF1c2541';
  String _backgroundColor = 'FFEDE7E3';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: const Text('Create new role'),
      content: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: size.width * 0.4,
            maxHeight: size.height * 0.5),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Identity', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20.0),
              InputControl(
                  formKey: _formKey,
                  label: 'Name',
                  initialValue: _name,
                  validator: validateName,
                  onSaved: (value) => _name = value!),
              const SizedBox(height: 8.0),
              InputControl(
                  formKey: _formKey,
                  label: 'Description',
                  initialValue: _description,
                  validator: validateDescription,
                  onSaved: (value) => _description = value!),
              const SizedBox(height: 8.0),
              InputColor(
                label: 'Text color',
                initialValue: _textColor,
                onChange: (color) => _textColor = color.hexAlpha,
              ),
              const SizedBox(height: 8.0),
              InputColor(
                label: 'Background color',
                initialValue: _backgroundColor,
                onChange: (color) => _backgroundColor = color.hexAlpha,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SubmitButton(
          label: 'Create',
          loading: ref.watch(roleStoreControllerProvider).isLoading,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              await ref.read(roleStoreControllerProvider.notifier).createRole({
                'name': _name,
                'description': _description,
                'textColor': _textColor,
                'backgroundColor': _backgroundColor,
              });

              ref.watch(roleStoreControllerProvider).when(
                  loading: () => {},
                  error: (error, stack) {
                    createErrorToast(
                      context,
                      label: 'Error',
                      description: 'An error occurred while create the role.',
                    );
                  },
                  data: (_) {
                    ref.invalidate(rolesControllerProvider);
                    Navigator.of(context).pop();

                    createSuccessToast(
                      context,
                      label: 'Success',
                      description: 'Role has been created successfully.',
                    );
                  });
            }
          },
        ),
      ],
    );
  }
}
