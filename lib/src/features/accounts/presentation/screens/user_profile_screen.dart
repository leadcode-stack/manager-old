import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/form/input_control.dart';
import 'package:manager/src/commons/widgets/toasts/error_toast.dart';
import 'package:manager/src/commons/widgets/toasts/success_toast.dart';
import 'package:manager/src/features/accounts/data/controllers/user_controller.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/data/validators/user_validators.dart';

final class UserProfileScreen extends ConsumerStatefulWidget {
  final User user;

  const UserProfileScreen({required this.user, super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
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
    final logs = [
      ('action', 'message'),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              await ref.read(userUpdateControllerProvider.notifier).updateUser(
                  widget.user.id, {
                'firstname': _firstName,
                'lastname': _lastName,
                'email': _email
              });

              ref.watch(userUpdateControllerProvider).when(
                  loading: () => {},
                  error: (error, stack) {
                    print('An error occurred while updating the user.');
                    createErrorToast(
                      context,
                      label: 'Error',
                      description: 'An error occurred while updating the user.',
                    );
                  },
                  data: (_) {
                    print('User has been updated successfully.');
                    createSuccessToast(
                      context,
                      label: 'Success',
                      description: 'User has been updated successfully.',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                            'https://ui-avatars.com/api/?name=${widget.user.firstname}+${widget.user.lastname}',
                            fit: BoxFit.cover))),
                const SizedBox(width: 8),
                Expanded(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(height: 20.0),
                                  InputControl(
                                      formKey: _formKey,
                                      label: 'Firstname',
                                      initialValue: widget.user.firstname,
                                      validator: validateFirstname,
                                      onSaved: (value) => _firstName = value!),
                                  const SizedBox(height: 8.0),
                                  InputControl(
                                      formKey: _formKey,
                                      label: 'Lastname',
                                      initialValue: widget.user.lastname,
                                      validator: validateLastname,
                                      onSaved: (value) => _lastName = value!),
                                  const SizedBox(height: 8.0),
                                  InputControl(
                                      formKey: _formKey,
                                      label: 'Email',
                                      initialValue: widget.user.email,
                                      validator: validateEmail,
                                      onSaved: (value) => _email = value!),
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                          padding: const EdgeInsets.all(16),
                          height: double.infinity,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Activity',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: logs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                        title: Text(logs[index].$1),
                                        subtitle: Text(logs[index].$1),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.only(left: 8, top: 8, right: 8),
//     child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.grey.shade200),
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8), topRight: Radius.circular(8))),
//         child: Text('cc')),
//   );
// }
