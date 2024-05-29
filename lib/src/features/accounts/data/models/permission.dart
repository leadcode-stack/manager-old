final class Permission {
  final int id;
  final String uid;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Permission({
    required this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}