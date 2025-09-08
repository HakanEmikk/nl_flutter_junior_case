import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/services/storage_services.dart';
import '../../features/auth/data/models/user_model.dart';

final LocalDataSourceProvider = Provider<LocalDataSource>((ref) {
  return LocalDataSource(ref.read(storageServiceProvider));
});

class LocalDataSource {
  final StorageService _storageService;

  LocalDataSource(this._storageService);

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
