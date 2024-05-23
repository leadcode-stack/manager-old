import 'package:manager/src/features/accounts/data/models/permission.dart';

final class Role {
  final int id;
  final String name;
  final String? description;
  final String textColor;
  final String backgroundColor;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.textColor,
    required this.backgroundColor,
    required this.createdAt,
    required this.updatedAt,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        textColor: json['textColor'],
        backgroundColor: json['backgroundColor'],
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        permissions: json['permissions'] != null
            ? List.from(json['permissions'])
                .map<Permission>(
                    (permission) => Permission.fromJson(permission))
                .toList()
            : []);
  }
}
