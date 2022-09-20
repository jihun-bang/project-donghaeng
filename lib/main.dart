import 'dart:ui';

import 'package:donghaeng/presentation/navigation/navigation.dart';
import 'package:donghaeng/presentation/navigation/route.dart';
import 'package:donghaeng/presentation/pages/sign_in_view.dart';
import 'package:donghaeng/presentation/provider/chat_room_viewmodel.dart';
import 'package:donghaeng/presentation/provider/sign_up_viewmodel.dart';
import 'package:donghaeng/presentation/provider/user_viewmodel.dart';
import 'package:donghaeng/presentation/theme/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'injection.dart';

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
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<UserViewModel>(
                create: (_) => sl<UserViewModel>()),
            ChangeNotifierProvider<ChatRoomViewModel>(
                create: (_) => sl<ChatRoomViewModel>()),
            ChangeNotifierProvider<SignUpViewModel>(
                create: (_) => sl<SignUpViewModel>()),
          ],
          child: MaterialApp(
            theme: themeDate,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              },
            ),
            navigatorKey: sl<NavigationService>().key,
            routes: routes(context),
            home: const SignInView(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
