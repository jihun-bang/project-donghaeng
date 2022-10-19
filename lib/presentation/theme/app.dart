import 'package:flutter/material.dart';

import 'color.dart';

ThemeData get themeDate => ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: primary,
    appBarTheme: _appbarThem,
    drawerTheme: _drawerTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    tabBarTheme: _tabBarTheme,
    fontFamily: 'Noto_Sans_KR');

final _appbarThem = AppBarTheme(
    titleTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black.withOpacity(0.6), size: 24),
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
    type: BottomNavigationBarType.fixed,
    elevation: 0);

final _tabBarTheme = TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.black.withOpacity(0.4),
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
    unselectedLabelStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.4)),
    indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.black, width: 2)));
