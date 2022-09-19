import 'package:flutter/material.dart';

import 'color.dart';

ThemeData get themeDate => ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: primary,
    appBarTheme: _appbarThem,
    drawerTheme: _drawerTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    fontFamily: 'Noto_Sans_KR');

const _appbarThem = AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0);

const _drawerTheme = DrawerThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(40))));

final _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black.withOpacity(0.2),
    backgroundColor: Colors.white,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed);
