import 'package:jr_case_boilerplate/core/models/movie_model.dart';

class MovieState {
  const MovieState.error(String error) : this._(error: error);
  const MovieState.loaded(List<MovieModel> movies)
    : this._(movies: movies, isLoading: false, isLoadingMore: false);
  const MovieState.loading() : this._(isLoading: true);
  const MovieState.loadingMore(List<MovieModel> movies)
    : this._(movies: movies, isLoading: false, isLoadingMore: true);

  const MovieState.initial() : this._();

  const MovieState._({
    this.movies = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });
  final List<MovieModel> movies;
  final bool isLoading;
  final String? error;
  final bool isLoadingMore;

  MovieState copyWith({
    List<MovieModel>? movies,
    bool? isLoading,
    String? error,
    bool? isLoadingMore,
  }) {
    return MovieState._(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}
