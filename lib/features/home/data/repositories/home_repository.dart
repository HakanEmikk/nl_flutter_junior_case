import 'package:jr_case_boilerplate/core/models/movie_model.dart';

abstract class HomeRepository {
  Future<List<MovieModel>> getMovie();
  Future<String?> getCachedToken();
  Future<MovieModel> setFavoriteMovie(String id);
}
