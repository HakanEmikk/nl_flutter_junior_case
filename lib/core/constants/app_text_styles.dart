import 'package:flutter/material.dart';

class AppTextStyles {
  // FONT FAMILY
  static const String _fontFamily = 'InstrumentSans';

  // HEADINGS
  static const TextStyle baseHeading = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading1 = baseHeading.copyWith(fontSize: 48);

  static TextStyle heading2 = baseHeading.copyWith(fontSize: 40);

  static TextStyle heading3 = baseHeading.copyWith(fontSize: 32);

  static TextStyle heading4 = baseHeading.copyWith(fontSize: 24);

  static TextStyle heading5 = baseHeading.copyWith(fontSize: 20);

  static TextStyle heading6 = baseHeading.copyWith(fontSize: 18);

  // Body XSmall - 10px
  static const TextStyle baseBodyXSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
  );

  static TextStyle bodyXSmallBold = baseBodyXSmall.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyXSmallSemiBold = baseBodyXSmall.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodyXSmallMedium = baseBodyXSmall.copyWith(
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyXSmallRegular = baseBodyXSmall.copyWith(
    fontWeight: FontWeight.w400,
  );

  // Body Small - 12px
  static const TextStyle baseBodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
  );

  static TextStyle bodySmallBold = baseBodySmall.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodySmallSemiBold = baseBodySmall.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodySmallMedium = baseBodySmall.copyWith(
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodySmallRegular = baseBodySmall.copyWith(
    fontWeight: FontWeight.w400,
  );

  // Body Normal - 14px
  static const TextStyle baseBodyNormal = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
  );

  static TextStyle bodyNormalBold = baseBodyNormal.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyNormalSemiBold = baseBodyNormal.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodyNormalMedium = baseBodyNormal.copyWith(
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyNormalRegular = baseBodyNormal.copyWith(
    fontWeight: FontWeight.w400,
  );

  // Body Large - 16px
  static const TextStyle baseBodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
  );

  static TextStyle bodyLargeBold = baseBodyLarge.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyLargeSemiBold = baseBodyLarge.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodyLargeMedium = baseBodyLarge.copyWith(
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyLargeRegular = baseBodyLarge.copyWith(
    fontWeight: FontWeight.w400,
  );
  // Body XLarge - 18px
  static const TextStyle baseBodyXLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
  );
  static TextStyle bodyXLargeBold = baseBodyXLarge.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyXLargeSemiBold = baseBodyXLarge.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodyXLargeMedium = baseBodyXLarge.copyWith(
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyXLargeReguler = baseBodyXLarge.copyWith(
    fontWeight: FontWeight.w400,
  );
}
