import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() {
    Timer(Duration(seconds: 3), () {
      if (mounted) {
        AppRoutes.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/Icon.png', width: 125, height: 125),
              SizedBox(height: 16),
              Text(
                "Shartflix",
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(color: AppColors.baseWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
