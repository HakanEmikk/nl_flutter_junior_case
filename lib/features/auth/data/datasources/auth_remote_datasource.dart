// lib/features/auth/data/datasources/auth_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.read(dioProvider));
});

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);
  final Dio _dio;

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post('user/login', data: request.toJson());

      final authResponse = AuthResponse.fromJson(response.data);

      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final requestData = {'email': email, 'password': password, 'name': name};

      final response = await _dio.post('user/register', data: requestData);

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post('auth/logout');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    String errorMessage = 'Beklenmeyen hata oluştu';

    if (e.response != null) {
      final responseData = e.response!.data;

      if (responseData is Map<String, dynamic>) {
        if (responseData['message'] != null &&
            responseData['message'].toString().isNotEmpty) {
          errorMessage = responseData['message'].toString();
        } else {
          switch (e.response!.statusCode) {
            case 400:
              errorMessage = 'E-posta veya şifre hatalı';
              break;
            case 422:
              errorMessage = 'Geçersiz veri formatı';
              break;
            case 500:
              errorMessage = 'Sunucu hatası';
              break;
            default:
              errorMessage = 'HTTP Error: ${e.response!.statusCode}';
          }
        }
      }
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Bağlantı zaman aşımı';
          break;
        case DioExceptionType.unknown:
          errorMessage = 'İnternet bağlantınızı kontrol edin';
          break;
        default:
          errorMessage = 'Ağ hatası: ${e.message}';
      }
    }

    return Exception(errorMessage);
  }
}
