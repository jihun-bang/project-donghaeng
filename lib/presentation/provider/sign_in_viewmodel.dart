import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/toast.dart';

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
}

enum SignInType {
  google('구글'),
  naver('네이버'),
  kakao('카카오');

  final String korean;
  const SignInType(this.korean);
}
