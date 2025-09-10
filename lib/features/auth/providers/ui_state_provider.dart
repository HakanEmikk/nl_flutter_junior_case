import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

final formValidationProvider = StateProvider<bool>((ref) => false);

final uiLoadingProvider = StateProvider<Map<String, bool>>((ref) => {});

final uiErrorProvider = StateProvider<Map<String, String?>>((ref) => {});

class UIState {
  final bool isPasswordVisible;
  final bool isFormValid;
  final Map<String, bool> loadingStates;
  final Map<String, String?> errorStates;

  const UIState({
    this.isPasswordVisible = false,
    this.isFormValid = false,
    this.loadingStates = const {},
    this.errorStates = const {},
  });

  UIState copyWith({
    bool? isPasswordVisible,
    bool? isFormValid,
    Map<String, bool>? loadingStates,
    Map<String, String?>? errorStates,
  }) {
    return UIState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isFormValid: isFormValid ?? this.isFormValid,
      loadingStates: loadingStates ?? this.loadingStates,
      errorStates: errorStates ?? this.errorStates,
    );
  }
}

final uiStateProvider = StateNotifierProvider<UIStateNotifier, UIState>((ref) {
  return UIStateNotifier();
});

class UIStateNotifier extends StateNotifier<UIState> {
  UIStateNotifier() : super(const UIState());

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

  void reset() {
    state = const UIState();
  }
}
