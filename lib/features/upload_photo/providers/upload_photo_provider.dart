import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/upload_photo/data/repositories/upload_photo_repository.dart';
import 'package:jr_case_boilerplate/features/upload_photo/data/repositories/upload_photo_repsitory_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jr_case_boilerplate/features/upload_photo/providers/upload_photo_state.dart';

final uploadPhotoProvider =
    StateNotifierProvider<UploadPhotoNotifier, UploadPhotoState>((ref) {
      return UploadPhotoNotifier(ref.read(uploadPhotoRepositoryProvider));
    });

class UploadPhotoNotifier extends StateNotifier<UploadPhotoState> {
  UploadPhotoNotifier(this._repository)
    : super(const UploadPhotoState.initial());
  final UploadPhotoRepository _repository;
  void photoloading() {
    state = const UploadPhotoState.photoLoading();
  }

  void photoloaded(XFile? image) {
    state = UploadPhotoState.photoLoaded(image);
  }

  void clearPhoto() {
    state = state.copyWith(isPhotoLoading: false, image: null);
  }

  Future<UserModel?> uploadPhoto(XFile image) async {
    state = const UploadPhotoState.loading();
    try {
      final user = await _repository.setPhoto(image);

      state = const UploadPhotoState.loaded();
    } catch (e) {
      state = UploadPhotoState.error(e.toString());
    }
  }
}
