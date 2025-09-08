import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';

abstract class ProfileRepository {
  Future<List<MovieModel>> getFavoriteMovie();
  Future<UserModel?> getCachedUser();
}
