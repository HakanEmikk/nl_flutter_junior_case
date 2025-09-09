import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/network/dio_provider.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/auth_response.dart';
import 'package:image_picker/image_picker.dart';

final uploadPhotoRemoteDatasourceProvider =
    Provider<UploadPhotoRemoteDatasource>((ref) {
      return UploadPhotoRemoteDatasource(ref.read(dioProvider));
    });

class UploadPhotoRemoteDatasource {
  UploadPhotoRemoteDatasource(this._dio);
  final Dio _dio;
  Future<AuthResponse> setPhoto(String? token, XFile imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_photo.${imageFile.path.split('.').last}',
        ),
      });

      final response = await _dio.post(
        'user/upload_photo',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: formData,
      );

      final uploadResponse = AuthResponse.fromJson(response.data);

      return uploadResponse;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Beklenmeyen hata oluştu');
    } catch (e) {
      rethrow;
    }
  }
}
