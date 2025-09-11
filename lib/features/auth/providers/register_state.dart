import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:jr_case_boilerplate/features/auth/providers/base_auth_state.dart';

class RegisterState extends BaseAuthState {
  const RegisterState({
    this.user,
    this.isRegistered = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.acceptTerms = false,
    super.isLoading,
    super.error,
  });
  const RegisterState.error(String error) : this(error: error);
  const RegisterState.registered(UserModel user)
    : this(user: user, isRegistered: true);
  const RegisterState.loading() : this(isLoading: true);

  const RegisterState.initial() : this();
  final UserModel? user;
  final bool isRegistered;

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool acceptTerms;

  @override
  RegisterState copyWith({
    UserModel? user,
    bool? isRegistered,
    bool? isLoading,
    String? error,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? acceptTerms,
  }) {
    return RegisterState(
      user: user ?? this.user,
      isRegistered: isRegistered ?? this.isRegistered,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      acceptTerms: acceptTerms ?? this.acceptTerms,
    );
  }
}
