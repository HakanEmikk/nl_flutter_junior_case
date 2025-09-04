// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/features/splash/view/splash_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => SplashView(),
  };

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
