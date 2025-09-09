import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/services/local_datasource.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:jr_case_boilerplate/features/upload_photo/data/datasources/upload_photo_remote_datasource.dart';
import 'package:jr_case_boilerplate/features/upload_photo/data/repositories/upload_photo_repository.dart';
import 'package:image_picker/image_picker.dart';

final uploadPhotoRepositoryProvider = Provider<UploadPhotoRepository>((ref) {
  return UploadPhotoRepsitoryImpl(
    ref.read(LocalDataSourceProvider),
    ref.read(uploadPhotoRemoteDatasourceProvider),
  );
});

class UploadPhotoRepsitoryImpl extends UploadPhotoRepository {
  UploadPhotoRepsitoryImpl(
    this._localDataSource,
    this._uploadPhotoRemoteDatasource,
  );
  final UploadPhotoRemoteDatasource _uploadPhotoRemoteDatasource;
  final LocalDataSource _localDataSource;
  @override
  Future<UserModel> setPhoto(XFile imageFile) async {
    try {
      final response = await _uploadPhotoRemoteDatasource.setPhoto(
        await _localDataSource.getCachedToken(),
        imageFile,
      );

      if (response.response.code == 200 && response.data != null) {
        final user = response.data.toUserModel();
        final token = await _localDataSource.getCachedToken();
        await _localDataSource.saveUserData(user, token!);
        return user;
      } else {
        throw Exception(
          response.response.message.isEmpty
              ? 'foto yüklenemedi'
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
}
