import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:jr_case_boilerplate/features/auth/providers/base_auth_state.dart';

class LoginState extends BaseAuthState {
  const LoginState({
    this.user,
    this.isAuthenticated = false,
    this.isPasswordVisible = false,
    this.isFormValid = false,
    this.loadingStates = const {},
    this.errorStates = const {},
    super.isLoading,
    super.error,
  });
  const LoginState.error(String error) : this(error: error);
  const LoginState.authenticated(UserModel user)
    : this(user: user, isAuthenticated: true);
  const LoginState.loading() : this(isLoading: true);

  const LoginState.initial() : this();
  final UserModel? user;
  final bool isAuthenticated;

  final bool isPasswordVisible;
  final bool isFormValid;
  final Map<String, bool> loadingStates;
  final Map<String, String?> errorStates;

  @override
  LoginState copyWith({
    UserModel? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
    bool? isPasswordVisible,
    bool? isFormValid,
    Map<String, bool>? loadingStates,
    Map<String, String?>? errorStates,
  }) {
    return LoginState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isFormValid: isFormValid ?? this.isFormValid,
      loadingStates: loadingStates ?? this.loadingStates,
      errorStates: errorStates ?? this.errorStates,
    );
  }
}
