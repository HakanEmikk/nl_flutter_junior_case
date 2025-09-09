import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
  });

  factory UserModel.fromJsonString(String jsonString) {
    return UserModel.fromJson(json.decode(jsonString));
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'photoUrl': photoUrl};
  }

  String toJsonString() => json.encode(toJson());
}
