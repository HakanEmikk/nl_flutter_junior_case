import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:jr_case_boilerplate/features/profile/data/repositories/profile_repository.dart';
import 'package:jr_case_boilerplate/features/profile/data/repositories/profile_respository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/profile/providers/profile_state.dart';

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
