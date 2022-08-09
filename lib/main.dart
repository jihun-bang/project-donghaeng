import 'dart:ui';

import 'package:donghaeng/view/base_view.dart';
import 'package:donghaeng/view/theme/color.dart';
import 'package:donghaeng/viewmodel/chat_viewmodel.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primary,
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<UserViewModel>(
          create: (_) => UserViewModel(),
        ),
        ChangeNotifierProvider<ChatViewModel>(
          create: (_) => ChatViewModel(),
        )
      ], child: const BaseView()),
    );
  }
}
