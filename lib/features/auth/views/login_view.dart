import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_primary_button.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_media_button.dart';
import 'package:lottie/lottie.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    print(isLargeScreen);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
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

                    SizedBox(height: 16),

                    // Şifremi unuttum
                    _buildForgotPassword(),

                    SizedBox(height: 8),

                    // Giriş yap butonu
                    _buildLoginButton(),

                    SizedBox(height: screenHeight * 0.02),

                    // Sosyal medya butonları
                    _buildSocialButtons(isSmallScreen),
                    SizedBox(height: 12),
                    // Hesap oluştur
                    _buildSignUpLink(),
                  ],
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
          child: Container(
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
    final logoSize = isSmallScreen ? 90.0 : 100.0;

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
          style: AppTextStyles.heading4.copyWith(color: AppColors.baseWhite),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Kullanıcı bilgilerinle giriş yap',
          style: AppTextStyles.bodyNormalRegular.copyWith(
            color: AppColors.baseWhite.withOpacity(0.7),
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
          style: AppTextStyles.bodyNormalSemiBold.copyWith(
            color: AppColors.baseWhite,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: CustomPrimaryButton(
        onPressed: () {
          _handleLogin();
        },
        child: Text(
          'Giriş Yap',
          style: AppTextStyles.bodyLargeSemiBold.copyWith(
            color: AppColors.baseWhite,
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
        SocialMediaButton(
          assetIcon: 'assets/images/Google.png',
          backgroundColor: AppColors.baseWhite.withOpacity(0.05),
          size: buttonSize,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        SocialMediaButton(
          assetIcon: 'assets/images/Apple.png',
          backgroundColor: AppColors.baseWhite.withOpacity(0.05),
          onTap: () {},
          size: buttonSize,
        ),
        const SizedBox(width: 8),
        SocialMediaButton(
          assetIcon: 'assets/images/Facebook.png',
          backgroundColor: AppColors.baseWhite.withOpacity(0.05),
          size: buttonSize,
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
          style: AppTextStyles.bodyNormalRegular.copyWith(
            color: AppColors.baseWhite.withOpacity(0.8),
          ),
        ),
        TextButton(
          onPressed: () {
            // Kayıt ol sayfasına git
          },
          child: Text(
            'Kayıt Ol',
            style: AppTextStyles.bodyNormalSemiBold.copyWith(
              color: AppColors.baseWhite,
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    // Ana sayfaya yönlendir
  }
}
