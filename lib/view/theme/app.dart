import 'package:flutter/material.dart';

import 'color.dart';

ThemeData get themeDate => ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: primary,
    appBarTheme: _appbarThem,
    fontFamily: 'Noto_Sans_KR');

const _appbarThem = AppBarTheme(
    backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0);
