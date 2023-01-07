import 'package:flutter/material.dart';

const int _primary = 0xFF414141;
const MaterialColor primary = MaterialColor(
  _primary,
  <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    350: Color(
        0xFFD6D6D6), // only for raised button while pressed in light theme
    400: Color(0xFFBDBDBD),
    500: Color(_primary),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    850: Color(0xFF303030), // only for background color in dark theme
    900: Color(0xFF212121),
  },
);

class MyColors {
  MyColors._();

  static Color get primary => const Color(0xFF35B7AC);

  static Color get subPrimary => const Color(0xFFFCCF42);

  static Color get grey_1 => const Color(0xFF9C9C9C);

  static Color get grey_2 => const Color(0xFFD9D9D9);

  static Color get grey_3 => const Color(0xFF757575);

  static Color get grey_200 => const Color(0xFFEBEBEB);
  
  // New Color Palette
  static Color get primeOrange => const Color(0xFFFF8266);

  static Color get primeOrange_600 => const Color(0xFFF27255);

  static Color get primeOrange_400 => const Color(0xFFFFB9A9);

  static Color get primeOrange_300 => const Color(0xFFFFD5CC);

  static Color get primeOrange_200 => const Color(0xFFFFE7E1);

  static Color get systemBlack => const Color(0xFF000000);

  static Color get systemSoftBlack => const Color(0xFF2B2B2B);

  static Color get systemGrey_500 => const Color(0xFFB3B3B3);

  static Color get systemGrey_400 => const Color(0xFFDCDCDC);

  static Color get systemGrey_300 => const Color(0xFFEBEBEB);

  static Color get error => const Color(0xFFFF3232); 

}
