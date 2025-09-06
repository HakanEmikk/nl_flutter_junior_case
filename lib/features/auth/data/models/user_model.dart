import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
  });

  factory UserModel.fromJsonString(String jsonString) {
    return UserModel.fromJson(json.decode(jsonString));
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'],
    );
  }
  final String id;
  final String email;
  final String name;
  final String? avatar;

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'avatar': avatar};
  }

  String toJsonString() => json.encode(toJson());
}
