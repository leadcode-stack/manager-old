import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/form/input_color.dart';
import 'package:manager/src/commons/widgets/form/input_control.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';

final class RoleEditScreen extends ConsumerStatefulWidget {
  final Role role;

  const RoleEditScreen({required this.role, super.key});

  @override
  ConsumerState<RoleEditScreen> createState() => _RoleEditScreenState();
}

class _RoleEditScreenState extends ConsumerState<RoleEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String? _description;
  late String _textColor;
  late String _backgroundColor;

  @override
  void initState() {
    super.initState();
    _name = widget.role.name;
    _description = widget.role.description;
    _textColor = widget.role.textColor;
    _backgroundColor = widget.role.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              await ref
                  .read(roleUpdateControllerProvider.notifier)
                  .updateRole(widget.role.id, {
                'name': _name,
                'description': _description,
                'textColor': _textColor,
                'backgroundColor': _backgroundColor
              });

              ref.watch(roleUpdateControllerProvider).when(
                  loading: () => {},
                  error: (error, stack) {
                    createErrorToast(
                      context,
                      label: 'Error',
                      description: 'An error occurred while updating the role.',
                    );
                  },
                  data: (_) {
                    createSuccessToast(
                      context,
                      label: 'Success',
                      description: 'Role has been updated successfully.',
                    );
                  });
            }
          },
          backgroundColor: Colors.blue.shade300,
          child: const Icon(Icons.save, color: Colors.white)),
      body: Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Identity',
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 20.0),
                            InputControl(
                                formKey: _formKey,
                                label: 'Name',
                                initialValue: widget.role.name,
                                onSaved: (value) => _name = value!),
                            const SizedBox(height: 8.0),
                            InputControl(
                                formKey: _formKey,
                                label: 'Description',
                                initialValue: widget.role.description,
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
                      )),
                ),
              ],
            ),
          )),
    );
  }
}