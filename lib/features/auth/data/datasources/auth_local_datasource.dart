import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/services/storage_services.dart';
import '../models/user_model.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource(ref.read(storageServiceProvider));
});

class AuthLocalDataSource {
  final StorageService _storageService;

  AuthLocalDataSource(this._storageService);

  Future<void> saveUserData(UserModel user, String token) async {
    await _storageService.saveUser(user.toJsonString());
    await _storageService.saveToken(token);
  }

  Future<UserModel?> getCachedUser() async {
    try {
      final userData = await _storageService.getUser();
      if (userData != null) {
        return UserModel.fromJsonString(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getCachedToken() async {
    return await _storageService.getToken();
  }

  Future<void> clearCache() async {
    await _storageService.clearAuth();
  }
}
