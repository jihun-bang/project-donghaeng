import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../injection.dart';
import '../provider/sign_in_viewmodel.dart';
import '../provider/user_viewmodel.dart';
import 'home_view.dart';
import 'profile_edit_view.dart';
import 'sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final signInViewModel = sl<SignInViewModel>();
  final userViewModel = sl<UserViewModel>();

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
            userViewModel.getUser();
            return Consumer<UserViewModel>(builder: (_, __, ___) {
              final user = userViewModel.user;
              if (userViewModel.getUserLoading) {
                return _loading;
              } else {
                if (user != null) {
                  if (user.name.isEmpty) {
                    return const ProfileEditView();
                  } else {
                    return const HomeView();
                  }
                } else {
                  return const SignUpView();
                }
              }
            });
          }
        },
      ),
    );
  }

  Widget get _loading => const Center(
        child: SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(strokeWidth: 10)),
      );

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
      final info = signInViewModel.getButtonInfo(type);

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
          onPressed: () async => await signInViewModel.signIn(type),
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
