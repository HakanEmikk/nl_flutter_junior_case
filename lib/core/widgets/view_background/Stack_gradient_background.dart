import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class StackGradientBackground extends StatelessWidget {
  final Widget child;

  const StackGradientBackground({Key? key, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ana linear gradient arka plan
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F0306), AppColors.gradientBlack],
              stops: [0, 0.4],
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
            ),
          ),
        ),

        // Üst kısım için radial gradient overlay
        Positioned(
          top: -50,
          left: -50,
          right: -50,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.6),
                radius: 0.8,
                colors: [
                  Color(0xffFF1B1B), // Açık kırmızı (şeffaf)
                  Color(0xff8d0000).withOpacity(0), // Şeffaf
                ],
                stops: [0.0, 0.9],
              ),
            ),
          ),
        ),
        // İçerik
        child,
      ],
    );
  }
}
