import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_primary_button.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/features/auth/providers/auth_providers.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_media_button.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;

  late AnimationController _lottieController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _lottieController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 380;
    final isLargeScreen = screenWidth > 600;

    final authState = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      // Sadece gerçekten state değiştiğinde çalış
      if (previous?.isAuthenticated != next.isAuthenticated ||
          previous?.error != next.error) {
        if (next.isAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kayıt başarılı!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (next.error != null && previous?.error != next.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );

          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              ref.read(authProvider.notifier).clearError();
            }
          });
        }
      }
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
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
                      _buildFormFields(),

                      const SizedBox(height: 16),

                      // Sözleşme onay kutusu
                      _buildTermsCheckbox(),

                      const SizedBox(height: 8),

                      // Kaydol butonu
                      _buildRegisterButton(),

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
          'Hesap Oluştur',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: AppColors.baseWhite),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Kullanıcı bilgilerini girerek kaydol',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.9),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        // Ad Soyad
        CustomTextFormField(
          controller: _nameController,
          hintText: 'Ad Soyad',
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ad soyad gerekli';
            }
            if (value.length < 3) {
              return 'En az 3 karakter girin';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // E-Posta
        CustomTextFormField(
          controller: _emailController,
          hintText: 'E-Posta',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'E-posta gerekli';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Geçerli bir e-posta girin';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // Şifre
        CustomTextFormField(
          controller: _passwordController,
          hintText: 'Şifre',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          isPasswordVisible: _isPasswordVisible,
          suffixIcon: _isPasswordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          onSuffixTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),

        const SizedBox(height: 16),

        // Şifre Tekrar
        CustomTextFormField(
          controller: _confirmPasswordController,
          hintText: 'Şifre Tekrar',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          isPasswordVisible: _isPasswordVisible,
          suffixIcon: _isPasswordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          onSuffixTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Şifre tekrar gerekli';
            }
            if (value != _passwordController.text) {
              return 'Şifreler uyuşmuyor';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _acceptTerms = !_acceptTerms;
            });
          },
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 2, right: 12),
            decoration: BoxDecoration(
              color: _acceptTerms
                  ? AppColors.primary
                  : AppColors.baseWhite.withOpacity(0.05),
              border: Border.all(
                color: AppColors.baseWhite.withOpacity(0.2),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: _acceptTerms
                ? Icon(Icons.check, size: 16, color: AppColors.baseWhite)
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

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: CustomPrimaryButton(
        onPressed: () {
          _handleRegister();
        },
        child: Text(
          'Kaydol',
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
          'Hesabın var mı? ',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            // Giriş sayfasına git
            AppRoutes.pushReplacementNamed(context, AppRoutes.login);
          },
          child: Text(
            'Giriş Yap',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final name = _nameController.text.trim();

      ref.read(authProvider.notifier).register(email, password, name);
    }
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen kullanıcı sözleşmesini kabul edin'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
  }
}
