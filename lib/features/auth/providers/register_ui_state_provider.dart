// register_ui_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterUIState {
  const RegisterUIState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.acceptTerms = false,
  });
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool acceptTerms;

  RegisterUIState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? acceptTerms,
  }) {
    return RegisterUIState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      acceptTerms: acceptTerms ?? this.acceptTerms,
    );
  }
}

final registerUIStateProvider =
    StateNotifierProvider<RegisterUIStateNotifier, RegisterUIState>((ref) {
      return RegisterUIStateNotifier();
    });

class RegisterUIStateNotifier extends StateNotifier<RegisterUIState> {
  RegisterUIStateNotifier() : super(const RegisterUIState());

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

  void reset() {
    state = const RegisterUIState();
  }
}

final registerPasswordVisibilityProvider = StateProvider<bool>((ref) => false);
final registerConfirmPasswordVisibilityProvider = StateProvider<bool>(
  (ref) => false,
);
final acceptTermsProvider = StateProvider<bool>((ref) => false);
