import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class UploadPhotoRepository {
  Future<UserModel> setPhoto(XFile imageFile);
}
