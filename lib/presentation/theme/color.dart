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
}
