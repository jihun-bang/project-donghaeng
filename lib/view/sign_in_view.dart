import 'package:donghaeng/data/di/locator.dart';
import 'package:donghaeng/view/base_view.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../viewmodel/login_viewmodel.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final viewModel = sl<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<User?>(
        initialData: FirebaseAuth.instance.currentUser,
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo,
                _signInList,
              ],
            );
          } else {
            return FutureBuilder(
                future: sl<UserViewModel>().addUser(),
                builder: (_, snapshot) => snapshot.hasData
                    ? const BaseView()
                    : const CircularProgressIndicator());
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
