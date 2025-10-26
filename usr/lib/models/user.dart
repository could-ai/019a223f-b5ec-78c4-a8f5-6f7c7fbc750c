class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final String? areaId;
  final DateTime createdAt;
  
  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    this.areaId,
    required this.createdAt,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
      areaId: json['area_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
      'area_id': areaId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
