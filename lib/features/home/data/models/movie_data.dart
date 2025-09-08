import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/home/data/models/pagination_model.dart';

class MovieData {
  MovieData({this.movie, this.movies, this.pagination});

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      movies:
          (json['movies'] as List<dynamic>?)
              ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
      movie: MovieModel.fromJson(json['movie'] ?? {}),
    );
  }
  final List<MovieModel>? movies;
  final MovieModel? movie;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() {
    return {
      'movies': movies!.map((e) => e.toJson()).toList(),
      'pagination': pagination!.toJson(),
      'movie': movie!.toJson(),
    };
  }
}
