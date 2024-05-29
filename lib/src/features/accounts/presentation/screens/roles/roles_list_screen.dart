import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/utils/pagination_navigator.dart';
import 'package:manager/src/features/accounts/data/models/role.dart';
import 'package:manager/src/features/accounts/domain/controllers/role_controller.dart';
import 'package:manager/src/features/accounts/presentation/forms/store_role_form.dart';
import 'package:manager/src/features/accounts/presentation/widgets/role_row.dart';

final class RolesListScreen extends ConsumerWidget {
  const RolesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Pagination<Role>> state =
        ref.watch(rolesControllerProvider);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const StoreRoleForm());
            }),
        body: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            color: Colors.grey.shade200,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                  color: Colors.white,
                ),
                child: state.when(
                    data: (pagination) => ListView.separated(
                          itemCount: pagination.data.length,
                      separatorBuilder: (context, index) =>
                              Divider(height: 1.0, color: Colors.grey.shade200),
                          itemBuilder: (context, index) {
                            final role = pagination.data[index];
                            return RoleRow(role: role);
                          },
                        ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text(e.toString())))));
  }
}
