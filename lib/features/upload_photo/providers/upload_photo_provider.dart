import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/upload_photo/data/repositories/upload_photo_repository.dart';
import 'package:jr_case_boilerplate/features/upload_photo/data/repositories/upload_photo_repsitory_impl.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoState {
  const UploadPhotoState.error(String error) : this._(error: error);
  const UploadPhotoState.loaded() : this._(isLoading: false);
  const UploadPhotoState.loading() : this._(isLoading: true);
  const UploadPhotoState.initial() : this._();
  const UploadPhotoState._({
    this.isLoading = false,
    this.error,
    this.user,
    this.isPhotoLoading = false,
    this.image,
  });
  const UploadPhotoState.photoLoading() : this._(isPhotoLoading: true);
  UploadPhotoState.photoLoaded(XFile? image)
    : this._(isPhotoLoading: false, image: image);
  final bool isLoading;
  final String? error;
  final UserModel? user;
  final bool isPhotoLoading;
  final XFile? image;

  UploadPhotoState copyWith({
    bool? isLoading,
    String? error,
    UserModel? user,
    bool? isPhotoLoading,
    XFile? image,
  }) {
    return UploadPhotoState._(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
      isPhotoLoading: isPhotoLoading ?? this.isPhotoLoading,
      image: image ?? image,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UploadPhotoState &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.user == user &&
        other.isPhotoLoading == isPhotoLoading &&
        other.image == image;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        error.hashCode ^
        user.hashCode ^
        isPhotoLoading.hashCode ^
        image.hashCode;
  }
}

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
