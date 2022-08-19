import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

ThemeData themeDate(BuildContext context) => ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: primary,
    appBarTheme: _appbarThem,
    textTheme: _textTheme(context));

const _appbarThem = AppBarTheme(
    backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0);

TextTheme _textTheme(BuildContext context) => GoogleFonts.notoSansTextTheme(
      Theme.of(context).textTheme,
    );
