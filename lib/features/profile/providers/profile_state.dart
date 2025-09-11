import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';

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
