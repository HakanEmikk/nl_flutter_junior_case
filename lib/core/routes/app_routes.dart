// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/features/auth/views/login_view.dart';
import 'package:jr_case_boilerplate/features/auth/views/register_view.dart';
import 'package:jr_case_boilerplate/features/home/view/home_view.dart';
import 'package:jr_case_boilerplate/features/nav_bar/view/nav_bar_view.dart';
import 'package:jr_case_boilerplate/features/splash/view/splash_view.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/upload_photo_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String navBar = '/nav-bar';
  static const String forgotPassword = '/forgot-password';
  static const String imageUpload = "/image-upload";

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashView(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildPageRoute(const SplashView(), settings);
      case login:
        return _buildPageRoute(const LoginView(), settings);
      case register:
        return _buildPageRoute(const RegisterView(), settings);
      case home:
        return _buildPageRoute(const HomeView(), settings);
      case navBar:
        return _buildPageRoute(const NavBarView(), settings);
      case imageUpload:
        return _buildPageRoute(const UploadPhotoView(), settings);
    }
    return null;
  }

  static PageRouteBuilder _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // sağdan sola
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return Transform(
          transform: Matrix4.identity()..rotateY(1.0 - animation.value),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }

  // Navigasyon helper metodları
  static void pushNamed(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  static void pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  static void pushNamedAndRemoveUntil(
    BuildContext context,
    String routeName, {
    bool removeAll = true,
  }) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      removeAll ? (route) => false : (route) => route.isFirst,
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pushWithArguments(
    BuildContext context,
    String routeName,
    Object arguments,
  ) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }
}
