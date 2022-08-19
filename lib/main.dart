import 'dart:ui';

import 'package:donghaeng/data/di/locator.dart';
import 'package:donghaeng/viewmodel/chat_viewmodel.dart';
import 'package:donghaeng/viewmodel/login_viewmodel.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'view/sign_in_view.dart';
import 'view/theme/app.dart';

Future<void> main() async {
  /// 환경 변수
  await dotenv.load(fileName: 'env');

  /// URL # 제거
  setPathUrlStrategy();

  /// Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterFireUIAuth.configureProviders([
    GoogleProviderConfiguration(clientId: dotenv.env['GOOGLE_CLIENT_ID']!),
  ]);

  /// 시스템 앱바 투명
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  /// 의존성 주입
  initLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeDate(context),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel()),
        ChangeNotifierProvider<ChatViewModel>(create: (_) => ChatViewModel()),
        ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel())
      ], child: const SignInView()),
    );
  }
}
