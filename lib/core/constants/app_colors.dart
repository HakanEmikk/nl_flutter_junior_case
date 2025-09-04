import 'package:flutter/widgets.dart';

class AppColors {
  static const Color primary = Color(0xFFE50914);
  static const Color primaryDark = Color(0xFF6F060B);
  static const Color secondary = Color(0xFF5949E6);
  // Base renk
  static const Color baseWhite = Color(0xFFFFFFFF);

  // Tonlama fonksiyonu
  static Color whiteTone(int percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be 0-100');

    // 0 -> siyah, 100 -> saf beyaz
    int value = (255 * percent / 100).round();
    return Color.fromARGB(255, value, value, value);
  }

  // Alert & Status
  static const Color success = Color(0xFF00C247);
  static const Color info = Color(0xFF004CE8);
  static const Color warming = Color(0xFFFFBE16);
  static const Color error = Color(0xFFF47171);
  // Others
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  //Gradients
  static const RadialGradient primaryGradient = RadialGradient(
    colors: [Color(0xFF3F0306), Color(0xFF090909)],
    stops: [0.2, 0.60],
    center: Alignment(0.0, -0.9),
    radius: 1.25,
    tileMode: TileMode.clamp,
  );
}
