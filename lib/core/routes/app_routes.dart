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

  // Route generator (dinamik routes için)
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );
      case register:
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
          settings: settings,
        );
      case navBar:
        return MaterialPageRoute(
          builder: (context) => const NavBarView(),
          settings: settings,
        );
      case imageUpload:
        return MaterialPageRoute(
          builder: (context) => const UploadPhotoView(),
          settings: settings,
        );
    }
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
