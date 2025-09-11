import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/home/data/repositories/home_repository.dart';
import 'package:jr_case_boilerplate/features/home/data/repositories/home_repository_impl.dart';

// Movie State
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

// Movie Provider
final movieProvider = StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier(ref.read(homeRepositoryProvider));
});

class MovieNotifier extends StateNotifier<MovieState> {
  MovieNotifier(this._repository) : super(const MovieState.initial());
  final HomeRepository _repository;
  int _currentPage = 1;
  bool _isFetching = false;

  Future<void> fetchMovies({bool loadMore = false}) async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      if (!loadMore) {
        _currentPage = 1;
      } else {
        state = MovieState.loadingMore(state.movies);
      }
      final newMovies = await _repository.getMovie(_currentPage);

      if (newMovies.isNotEmpty) {
        final updatedMovies = loadMore
            ? [...state.movies, ...newMovies]
            : newMovies;

        _currentPage++;

        state = MovieState.loaded(updatedMovies);
      } else {
        state = state.copyWith(isLoading: false, isLoadingMore: false);
      }
    } catch (e) {
      state = MovieState.error(e.toString());
    } finally {
      _isFetching = false;
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
