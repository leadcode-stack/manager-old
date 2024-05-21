final class Permission {
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Permission({
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}