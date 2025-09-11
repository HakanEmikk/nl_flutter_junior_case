import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/home/data/repositories/home_repository.dart';
import 'package:jr_case_boilerplate/features/home/data/repositories/home_repository_impl.dart';
import 'package:jr_case_boilerplate/features/home/providers/movie_state.dart';

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
      await _repository.setFavoriteMovie(id);

      final updatedMovies = state.movies.map((movie) {
        if (movie.id == id) {
          return movie.copyWith(isFavorite: !movie.isFavorite!);
        }
        return movie;
      }).toList();

      state = state.copyWith(movies: updatedMovies);
    } catch (e) {}
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}
