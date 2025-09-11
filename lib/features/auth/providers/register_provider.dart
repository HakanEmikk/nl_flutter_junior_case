// register_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/auth/data/repositories/auth_repository.dart';
import 'package:jr_case_boilerplate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:jr_case_boilerplate/features/auth/providers/register_state.dart';

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (ref) {
    return RegisterNotifier(ref.read(authRepositoryProvider));
  },
);

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier(this._repository) : super(const RegisterState.initial());
  final AuthRepository _repository;

  Future<void> register(String email, String password, String name) async {
    state = const RegisterState.loading().copyWith(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      acceptTerms: state.acceptTerms,
    );

    try {
      final user = await _repository.register(email, password, name);
      state = RegisterState.registered(user).copyWith(
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        acceptTerms: state.acceptTerms,
      );
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceFirst('Exception:', '');
      }
      state = RegisterState.error(errorMessage).copyWith(
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        acceptTerms: state.acceptTerms,
      );
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  void reset() {
    state = const RegisterState.initial();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void toggleAcceptTerms() {
    state = state.copyWith(acceptTerms: !state.acceptTerms);
  }

  void setAcceptTerms(bool value) {
    state = state.copyWith(acceptTerms: value);
  }

  void resetUIState() {
    state = state.copyWith(
      isPasswordVisible: false,
      isConfirmPasswordVisible: false,
      acceptTerms: false,
    );
  }

  void clearRegisterState() {
    state = state.copyWith(isRegistered: false, error: null, isLoading: false);
  }
}
