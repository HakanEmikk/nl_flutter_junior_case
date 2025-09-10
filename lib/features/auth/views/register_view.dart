import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/helpers/snackbar_helper.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_primary_button.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/core/widgets/view_background/Stack_gradient_background.dart';
import 'package:jr_case_boilerplate/features/auth/providers/auth_providers.dart';
import 'package:jr_case_boilerplate/features/auth/providers/register_ui_state_provider.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_media_button.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView>
    with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 380;
    final isLargeScreen = screenWidth > 600;

    final authState = ref.watch(authProvider);
    final registerUIState = ref.watch(registerUIStateProvider);

    ref.listen(authProvider, (previous, next) {
      if (previous?.isRegisterAuthenticated != next.isRegisterAuthenticated ||
          previous?.error != next.error) {
        if (next.isRegisterAuthenticated) {
          SnackbarHelper.success(
            context,
            AppLocalizations.of(context)!.registerSuccess,
          );
          AppRoutes.pushNamed(context, AppRoutes.login);
        } else if (next.error != null && previous?.error != next.error) {
          SnackbarHelper.error(context, next.error!);
        }
      }
    });
    return Scaffold(
      body: StackGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen ? 48.0 : 20.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight - MediaQuery.of(context).padding.top,
                maxWidth: isLargeScreen ? 400 : double.infinity,
              ),
              child: Form(
                key: _formKey,
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.06),

                      // Ana logo
                      _buildLogo(isSmallScreen),

                      SizedBox(height: screenHeight * 0.0231),

                      // Başlık ve açıklama
                      _buildHeader(),

                      SizedBox(height: screenHeight * 0.0168),

                      // Form alanları
                      _buildFormFields(registerUIState),

                      const SizedBox(height: 16),

                      // Sözleşme onay kutusu
                      _buildTermsCheckbox(registerUIState),

                      const SizedBox(height: 8),

                      // Kaydol butonu
                      _buildRegisterButton(authState, registerUIState),

                      SizedBox(height: screenHeight * 0.0084),

                      // Sosyal medya butonları
                      _buildSocialButtons(isSmallScreen),

                      const SizedBox(height: 8),

                      // Giriş yap linki
                      _buildLoginLink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isSmallScreen) {
    final logoSize = isSmallScreen ? 68.0 : 78.0;

    return Center(
      child: Image.asset(
        'assets/images/Icon.png',
        width: logoSize,
        height: logoSize,
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.createAccount,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: AppColors.baseWhite),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.enterInfo,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.9),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormFields(RegisterUIState uiState) {
    return Column(
      children: [
        // Ad Soyad
        CustomTextFormField(
          controller: _nameController,
          hintText: AppLocalizations.of(context)!.enterName,
          prefixIcon: 'assets/images/User.png',
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.nameRequired;
            }
            if (value.length < 3) {
              return AppLocalizations.of(context)!.nameMinChars;
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // E-Posta
        CustomTextFormField(
          controller: _emailController,
          hintText: AppLocalizations.of(context)!.enterEmail,
          prefixIcon: 'assets/images/Mail.png',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.emailRequired;
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return AppLocalizations.of(context)!.emailInvalid;
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // Şifre
        CustomTextFormField(
          controller: _passwordController,
          hintText: AppLocalizations.of(context)!.enterPassword,
          prefixIcon: 'assets/images/Lock.png',
          isPassword: true,
          isPasswordVisible: uiState.isPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.passwordRequired;
            }
            if (value.length < 6) {
              return AppLocalizations.of(context)!.passwordMinLength;
            }
            return null;
          },
          suffixIcon: !uiState.isPasswordVisible
              ? 'assets/images/Hide.png'
              : 'assets/images/See.png',
          onSuffixTap: () {
            ref
                .read(registerUIStateProvider.notifier)
                .togglePasswordVisibility();
          },
        ),

        const SizedBox(height: 16),

        // Şifre Tekrar
        CustomTextFormField(
          controller: _confirmPasswordController,
          hintText: AppLocalizations.of(context)!.enterConfirmPassword,
          prefixIcon: 'assets/images/Lock.png',
          isPassword: true,
          isPasswordVisible: uiState.isConfirmPasswordVisible,
          suffixIcon: !uiState.isConfirmPasswordVisible
              ? 'assets/images/Hide.png'
              : 'assets/images/See.png',
          onSuffixTap: () {
            ref
                .read(registerUIStateProvider.notifier)
                .toggleConfirmPasswordVisibility();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.confirmPasswordRequired;
            }
            if (value != _passwordController.text) {
              return AppLocalizations.of(context)!.passwordsDoNotMatch;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(RegisterUIState uiState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            ref.read(registerUIStateProvider.notifier).toggleAcceptTerms();
          },
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 2, right: 12),
            decoration: BoxDecoration(
              color: uiState.acceptTerms
                  ? AppColors.primary
                  : AppColors.baseWhite.withOpacity(0.05),
              border: Border.all(
                color: AppColors.baseWhite.withOpacity(0.2),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: uiState.acceptTerms
                ? const Icon(Icons.check, size: 16, color: AppColors.baseWhite)
                : null,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'Kullanıcı sözleşmesini ',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.baseWhite.withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: 'Okudum ve Kabul ediyorum',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.baseWhite.withOpacity(0.6),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
                TextSpan(
                  text: '. Bu sözleşmeyi okuyarak devam ediniz lütfen.',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.baseWhite.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(AuthState authState, RegisterUIState uiState) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: CustomPrimaryButton(
        onPressed: authState.isLoading ? null : () => _handleRegister(uiState),

        child: authState.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                AppLocalizations.of(context)!.register,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildSocialButtons(bool isSmallScreen) {
    final buttonSize = isSmallScreen ? 50.0 : 60.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SocialMediaButton(
            assetIcon: 'assets/images/Google.png',
            backgroundColor: AppColors.baseWhite.withOpacity(0.05),
            size: buttonSize,
            onTap: () {},
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SocialMediaButton(
            assetIcon: 'assets/images/Apple.png',
            backgroundColor: AppColors.baseWhite.withOpacity(0.05),
            onTap: () {},
            size: buttonSize,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SocialMediaButton(
            assetIcon: 'assets/images/Facebook.png',
            backgroundColor: AppColors.baseWhite.withOpacity(0.05),
            size: buttonSize,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.haveAccount,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(registerUIStateProvider.notifier).reset();
            // Giriş sayfasına git
            AppRoutes.pushNamed(context, AppRoutes.login);
          },
          child: Text(
            AppLocalizations.of(context)!.login,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleRegister(RegisterUIState uiState) {
    if (!uiState.acceptTerms) {
      SnackbarHelper.info(
        context,
        AppLocalizations.of(context)!.acceptTermsError,
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final name = _nameController.text.trim();

      ref.read(authProvider.notifier).register(email, password, name);
    }
  }
}
