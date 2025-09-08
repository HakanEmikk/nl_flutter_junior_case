import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:jr_case_boilerplate/features/profile/data/repositories/profile_repository.dart';
import 'package:jr_case_boilerplate/features/profile/data/repositories/profile_respository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  const ProfileState.error(String error) : this._(error: error);
  const ProfileState.loaded(List<MovieModel> movies, UserModel? user)
    : this._(movies: movies, isLoading: false, user: user);
  ProfileState.loading(UserModel? user) : this._(isLoading: true, user: user);

  const ProfileState.initial() : this._();
  const ProfileState._({
    this.movies = const [],
    this.isLoading = false,
    this.error,
    this.user,
  });
  final List<MovieModel> movies;
  final bool isLoading;
  final String? error;
  final UserModel? user;

  ProfileState copyWith({
    List<MovieModel>? movies,
    bool? isLoading,
    String? error,
    UserModel? user,
  }) {
    return ProfileState._(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  return ProfileNotifier(ref.read(profileRepositoryProvider));
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this._repository) : super(const ProfileState.initial());
  final ProfileRepository _repository;

  Future<void> fetchFavoriteMovies() async {
    final user = await getCachedUser();
    state = ProfileState.loading(user);
    try {
      final movies = await _repository.getFavoriteMovie();

      state = ProfileState.loaded(movies, user);
    } catch (e) {
      state = ProfileState.error(e.toString());
    }
  }

  Future<UserModel?> getCachedUser() async {
    try {
      final user = await _repository.getCachedUser();
      return user;
    } catch (e) {}
  }
}
