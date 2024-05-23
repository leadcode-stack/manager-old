import 'package:manager/src/features/accounts/data/models/role.dart';

final class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime createdAt;
  final DateTime? updatedAt;

  final List<Role> roles;

  String get username => '$firstname $lastname';

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      roles: json['roles'] != null
          ? List.from(json['roles'])
          .map<Role>((role) => Role.fromJson(role))
          .toList()
          : [],
    );
  }
}
