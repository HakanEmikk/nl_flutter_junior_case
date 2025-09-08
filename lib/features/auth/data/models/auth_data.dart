import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';

class AuthData {
  AuthData({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.token,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      id: json['_id'] ?? '',
      userId: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      token: json['token'] ?? '',
    );
  }
  final String id;
  final String userId;
  final String name;
  final String email;
  final String photoUrl;
  final String token;
  UserModel toUserModel() {
    return UserModel(
      id: userId.isNotEmpty ? userId : id,
      email: email,
      name: name,
      photoUrl: photoUrl.isNotEmpty ? photoUrl : null,
    );
  }
}
