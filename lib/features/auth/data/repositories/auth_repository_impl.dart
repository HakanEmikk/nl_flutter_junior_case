import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/services/local_datasource.dart';
import '../models/user_model.dart';
import '../models/login_request.dart';
import 'auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(LocalDataSourceProvider),
  );
});

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);
  final AuthRemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _remoteDataSource.login(request);

      if (response.response.code == 200 && response.data != null) {
        final user = response.data.toUserModel();
        final token = response.data.token;
        await _localDataSource.saveUserData(user, token);
        return user;
      } else {
        throw Exception(
          response.response.message.isEmpty
              ? 'Giriş başarısız'
              : response.response.message,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final response = await _remoteDataSource.register(email, password, name);

      if (response.response.code == 200 && response.data != null) {
        final user = response.data.toUserModel();
        final token = response.data.token;

        await _localDataSource.saveUserData(user, token);

        return user;
      } else {
        throw Exception(
          response.response.message.isEmpty
              ? 'Kayıt başarısız'
              : response.response.message,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (e) {
    } finally {
      await _localDataSource.clearCache();
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      return await _localDataSource.getCachedUser();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getCachedToken() async {
    try {
      return await _localDataSource.getCachedToken();
    } catch (e) {
      return null;
    }
  }
}
