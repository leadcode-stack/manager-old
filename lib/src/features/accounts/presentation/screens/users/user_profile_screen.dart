import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/src/commons/widgets/frame.dart';
import 'package:manager/src/features/accounts/data/models/user.dart';
import 'package:manager/src/features/accounts/presentation/widgets/user_profile_identity_panel.dart';
import 'package:manager/src/features/accounts/presentation/widgets/user_profile_roles_panel.dart';

final class UserProfileScreen extends ConsumerStatefulWidget {
  final User user;

  const UserProfileScreen({required this.user, super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(16.0),
        child: Frame(
            child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
              UserProfileIdentityPanel(user: widget.user),
              UserProfileRolesPanel(user: widget.user),
            ])),
      ),
    );
  }
}
