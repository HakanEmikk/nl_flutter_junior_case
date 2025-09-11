// login_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/auth/data/repositories/auth_repository.dart';
import 'package:jr_case_boilerplate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:jr_case_boilerplate/features/auth/providers/login_state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref.read(authRepositoryProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._repository) : super(const LoginState.initial());
  final AuthRepository _repository;

  Future<void> _checkAuthStatus() async {
    try {
      final user = await _repository.getCachedUser();
      final token = await _repository.getCachedToken();

      if (user != null && token != null) {
        state = LoginState.authenticated(user).copyWith(
          isPasswordVisible: state.isPasswordVisible,
          isFormValid: state.isFormValid,
          loadingStates: state.loadingStates,
          errorStates: state.errorStates,
        );
      }
    } catch (e) {}
  }

  Future<void> login(String email, String password) async {
    state = const LoginState.loading().copyWith(
      isPasswordVisible: state.isPasswordVisible,
      isFormValid: state.isFormValid,
      loadingStates: state.loadingStates,
      errorStates: state.errorStates,
    );

    try {
      final user = await _repository.login(email, password);
      state = LoginState.authenticated(user).copyWith(
        isPasswordVisible: state.isPasswordVisible,
        isFormValid: state.isFormValid,
        loadingStates: state.loadingStates,
        errorStates: state.errorStates,
      );
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceFirst('Exception:', '');
      }
      state = LoginState.error(errorMessage).copyWith(
        isPasswordVisible: state.isPasswordVisible,
        isFormValid: state.isFormValid,
        loadingStates: state.loadingStates,
        errorStates: state.errorStates,
      );
    }
  }

  Future<void> logout() async {
    state = const LoginState.loading().copyWith(
      isPasswordVisible: state.isPasswordVisible,
      isFormValid: state.isFormValid,
      loadingStates: state.loadingStates,
      errorStates: state.errorStates,
    );

    try {
      await _repository.logout();
      state = const LoginState.initial();
    } catch (e) {
      state = LoginState.error(e.toString()).copyWith(
        isPasswordVisible: state.isPasswordVisible,
        isFormValid: state.isFormValid,
        loadingStates: state.loadingStates,
        errorStates: state.errorStates,
      );
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  void reset() {
    state = const LoginState.initial();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void setFormValid(bool isValid) {
    state = state.copyWith(isFormValid: isValid);
  }

  void setLoadingState(String key, bool isLoading) {
    final newLoadingStates = Map<String, bool>.from(state.loadingStates);
    newLoadingStates[key] = isLoading;
    state = state.copyWith(loadingStates: newLoadingStates);
  }

  void setErrorState(String key, String? error) {
    final newErrorStates = Map<String, String?>.from(state.errorStates);
    newErrorStates[key] = error;
    state = state.copyWith(errorStates: newErrorStates);
  }

  void clearErrorState(String key) {
    final newErrorStates = Map<String, String?>.from(state.errorStates);
    newErrorStates.remove(key);
    state = state.copyWith(errorStates: newErrorStates);
  }

  void resetUIState() {
    state = state.copyWith(
      isPasswordVisible: false,
      isFormValid: false,
      loadingStates: const {},
      errorStates: const {},
    );
  }

  void clearLoginState() {
    state = state.copyWith(
      isAuthenticated: false,
      error: null,
      isLoading: false,
    );
  }
}
