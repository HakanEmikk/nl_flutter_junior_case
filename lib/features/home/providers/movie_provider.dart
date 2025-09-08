import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/home/data/repositories/home_repository.dart';
import 'package:jr_case_boilerplate/features/home/data/repositories/home_repository_impl.dart';

// Movie State
class MovieState {
  const MovieState.error(String error) : this._(error: error);
  const MovieState.loaded(List<MovieModel> movies)
    : this._(movies: movies, isLoading: false);
  const MovieState.loading() : this._(isLoading: true);

  const MovieState.initial() : this._();

  const MovieState._({
    this.movies = const [],
    this.isLoading = false,
    this.error,
  });
  final List<MovieModel> movies;
  final bool isLoading;
  final String? error;

  MovieState copyWith({
    List<MovieModel>? movies,
    bool? isLoading,
    String? error,
  }) {
    return MovieState._(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Movie Provider
final movieProvider = StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier(ref.read(homeRepositoryProvider));
});

class MovieNotifier extends StateNotifier<MovieState> {
  MovieNotifier(this._repository) : super(const MovieState.initial());
  final HomeRepository _repository;

  Future<void> fetchMovies() async {
    state = const MovieState.loading();
    try {
      final movies = await _repository.getMovie();
      state = MovieState.loaded(movies);
    } catch (e) {
      state = MovieState.error(e.toString());
    }
  }

  Future<void> setFavoriteMovie(String id) async {
    try {
      final Movies = await _repository.setFavoriteMovie(id);
    } catch (e) {}
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}
