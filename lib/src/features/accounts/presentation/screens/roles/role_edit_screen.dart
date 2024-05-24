import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/features/accounts/presentation/forms/update_role_form.dart';

final class RoleEditScreen extends ConsumerStatefulWidget {
  final Role role;

  const RoleEditScreen({required this.role, super.key});

  @override
  ConsumerState<RoleEditScreen> createState() => _RoleEditScreenState();
}

class _RoleEditScreenState extends ConsumerState<RoleEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: UpdateRoleForm(
            role: widget.role,
            onSubmit: (payload) async {
              await ref
                  .read(roleUpdateControllerProvider.notifier)
                  .updateRole(widget.role.id, payload);

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
                    ref.invalidate(rolesControllerProvider);
                    createSuccessToast(
                      context,
                      label: 'Success',
                      description: 'Role has been updated successfully.',
                    );
                  });
            }));
  }
}
