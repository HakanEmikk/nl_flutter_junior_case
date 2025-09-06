import 'package:jr_case_boilerplate/features/auth/data/models/auth_data.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/response_info.dart';

class AuthResponse {
  final ResponseInfo response;
  final AuthData data;

  AuthResponse({required this.response, required this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      response: ResponseInfo.fromJson(json['response']),
      data: AuthData.fromJson(json['data']),
    );
  }
}
