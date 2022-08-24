import 'package:donghaeng/data/di/locator.dart';
import 'package:donghaeng/model/user.dart' as u;
import 'package:donghaeng/view/home_view.dart';
import 'package:donghaeng/view/profile_edit_view.dart';
import 'package:donghaeng/view/sign_up_view.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../viewmodel/sign_in_viewmodel.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final viewModel = sl<SignInViewModel>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData &&
              FirebaseAuth.instance.currentUser?.email == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo,
                _signInList,
              ],
            );
          } else {
            return FutureBuilder<u.User?>(
                future: sl<UserViewModel>().getUser(),
                builder: (_, snapshot) {
                  if (snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.done) {
                    final user = snapshot.data;
                    if (user == null) {
                      return const SignUpView();
                    } else {
                      if (user.name.isEmpty) {
                        return const ProfileEditView();
                      } else {
                        return const HomeView();
                      }
                    }
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(
                          '로딩 중 🚴‍',
                          textScaleFactor: 2,
                        ),
                      ),
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(strokeWidth: 10)),
                    ],
                  );
                });
          }
        },
      ),
    );
  }

  Widget get _logo => const Expanded(
        flex: 3,
        child: Center(
          child: Text(
            '동행',
            style: TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget get _signInList {
    Widget button(SignInType type) {
      final info = viewModel.getButtonInfo(type);

      return Padding(
        padding: const EdgeInsets.only(bottom: 11),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.only(left: 18, right: 18),
              backgroundColor: info.item3,
              minimumSize: const Size(300, 60),
              maximumSize: const Size(400, 60),
              side:
                  BorderSide(width: 0.5, color: Colors.black.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () async => await viewModel.signIn(type),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/icons/icon_${type.name}.svg',
                      fit: BoxFit.contain,
                    )),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${info.item1} 로그인',
                    style: TextStyle(
                        fontSize: 16,
                        color: info.item2,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      );
    }

    return Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: SignInType.values.map((type) => button(type)).toList(),
        ));
  }
}