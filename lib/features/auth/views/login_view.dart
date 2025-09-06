import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_primary_button.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/features/auth/providers/auth_providers.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_media_button.dart';
import 'package:lottie/lottie.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = true;

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
    _fadeAnimation = Tween<double>(begin: 0.0, end: 9.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Animasyonları başlat
    _fadeController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              content: Text('Giriş başarılı!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
          AppRoutes.pushReplacementNamed(context, AppRoutes.home);
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
                      // Lottie animasyon + filmler
                      _buildAnimationSection(isSmallScreen),

                      SizedBox(height: screenHeight * 0.03),

                      // Ana logo
                      _buildLogo(isSmallScreen),

                      SizedBox(height: screenHeight * 0.0231),

                      // Başlık ve açıklama
                      _buildHeader(),

                      SizedBox(height: screenHeight * 0.0168),

                      // Form alanları
                      _buildFormFields(),

                      const SizedBox(height: 16),

                      // Şifremi unuttum
                      _buildForgotPassword(),

                      const SizedBox(height: 8),

                      // Giriş yap butonu
                      _buildLoginButton(authState),

                      SizedBox(height: screenHeight * 0.02),

                      // Sosyal medya butonları
                      _buildSocialButtons(isSmallScreen),
                      const SizedBox(height: 8),
                      // Hesap oluştur
                      _buildSignUpLink(),
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

  Widget _buildAnimationSection(bool isSmallScreen) {
    return Column(
      children: [
        Transform.scale(
          scale: 1.5,
          child: SizedBox(
            height: isSmallScreen ? 100 : 150,
            child: Lottie.asset(
              'assets/animations/Artboard_1.json',
              controller: _lottieController,
              fit: BoxFit.contain,
              repeat: true,
              animate: true,
              onLoaded: (composition) {
                _lottieController
                  ..duration = composition.duration
                  ..forward()
                  ..repeat();
              },
              errorBuilder: (context, error, stackTrace) {
                return _buildMovieCards(isSmallScreen);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCards(bool isSmallScreen) {
    final cardWidth = isSmallScreen ? 50.0 : 60.0;
    final cardHeight = isSmallScreen ? 70.0 : 80.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMovieCard('assets/images/movie1.png', cardWidth, cardHeight),
        _buildMovieCard('assets/images/movie2.png', cardWidth, cardHeight),
        _buildMovieCard('assets/images/movie3.png', cardWidth, cardHeight),
        _buildMovieCard('assets/images/movie4.png', cardWidth, cardHeight),
      ],
    );
  }

  Widget _buildMovieCard(String imagePath, double width, double height) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[800],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[700],
              child: Icon(Icons.movie, color: Colors.grey, size: width * 0.4),
            );
          },
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
          'Giriş Yap',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: AppColors.baseWhite),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Kullanıcı bilgilerinle giriş yap',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.7),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Şifre gerekli';
            }
            if (value.length < 6) {
              return 'Şifre en az 6 karakter olmalı';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Şifre Unuttum',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(AuthState authState) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: CustomPrimaryButton(
        onPressed: authState.isLoading ? null : _handleLogin,
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
                'Giriş Yap',
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

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Bir hesabın yok mu? ',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            AppRoutes.pushReplacementNamed(context, AppRoutes.register);
          },
          child: Text(
            'Kayıt Ol',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Auth provider ile login işlemi
      ref.read(authProvider.notifier).login(email, password);
    }
  }
}
