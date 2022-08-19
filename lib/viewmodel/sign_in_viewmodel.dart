import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tuple/tuple.dart';

import '../utils/toast.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel();

  Future<void> signIn(SignInType type) async {
    switch (type) {
      case SignInType.google:
        _signInWithGoogle();
        break;
      case SignInType.naver:
      case SignInType.kakao:
        showToast(message: '서비스 준비중입니다 😥');
        break;
    }
  }

  Future<UserCredential> _signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Tuple3 getButtonInfo(SignInType type) {
    switch (type) {
      case SignInType.google:
        return Tuple3('구글', Colors.black.withOpacity(0.6), Colors.white);
      case SignInType.naver:
        return const Tuple3('네이버', Colors.white, Color(0xFF00C73C));
      case SignInType.kakao:
        return const Tuple3('카카오', Color(0xFF3D1B1A), Color(0XFFFFE812));
    }
  }
}

enum SignInType { google, naver, kakao }
