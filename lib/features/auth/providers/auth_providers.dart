import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:jr_case_boilerplate/features/auth/data/repositories/auth_repository.dart';
import 'package:jr_case_boilerplate/features/auth/data/repositories/auth_repository_impl.dart';

// Auth State
class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;
  final bool isRegisterAuthenticated;

  const AuthState._({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
    this.isRegisterAuthenticated = false,
  });

  const AuthState.initial() : this._();
  const AuthState.loading() : this._(isLoading: true);
  const AuthState.authenticated(UserModel user)
    : this._(user: user, isAuthenticated: true);
  const AuthState.registerAuthenticated(UserModel user)
    : this._(user: user, isRegisterAuthenticated: true);
  const AuthState.unauthenticated() : this._();
  const AuthState.error(String error) : this._(error: error);

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
    bool? isRegisterAuthenticated,
  }) {
    return AuthState._(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isRegisterAuthenticated:
          isRegisterAuthenticated ?? this.isRegisterAuthenticated,
    );
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initial());

  Future<void> _checkAuthStatus() async {
    try {
      final user = await _repository.getCachedUser();
      final token = await _repository.getCachedToken();

      if (user != null && token != null) {
        state = AuthState.authenticated(user);
      }
    } catch (e) {}
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    try {
      final user = await _repository.login(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      if (e.toString().contains('Exception:')) {
        state = AuthState.error(e.toString().replaceFirst('Exception:', ''));
      }
    }
  }

  Future<void> register(String email, String password, String name) async {
    state = const AuthState.loading();

    try {
      final user = await _repository.register(email, password, name);
      state = AuthState.registerAuthenticated(user);
    } catch (e) {
      if (e.toString().contains('Exception:')) {
        state = AuthState.error(e.toString().replaceFirst('Exception:', ''));
      }
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}
