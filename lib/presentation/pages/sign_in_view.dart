import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:donghaeng/presentation/theme/color.dart';
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
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData &&
              FirebaseAuth.instance.currentUser?.email == null) {
            return Container(
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              child: CustomScrollView(
                slivers: [
                  SliverFillViewport(
                    delegate: SliverChildListDelegate([]),
                    viewportFraction: 0.8,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    _buildLogo,
                    _signUp,
                    _buildDivider,
                    // _buildInfo,
                    _buildSignInList,
                    _buildFooter
                  ]))
                ],
              ),
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

  Widget get _loading => Container(
      color: MyColors.primeOrange,
      alignment: Alignment.center,
        child: SvgPicture.asset('assets/icons/main_logo.svg'),
  );

  Widget get _buildLogo => Container(
        width: 352,
        height: 247,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SvgPicture.asset('assets/icons/main_logo.svg'),
      );

  //! check if it should be removed or not
  // Widget get _buildInfo => const Padding(
  //       padding: EdgeInsets.only(bottom: 28),
  //       child: Text(
  //         '로그인 하면 GiGi 이용약관에 동의하는 것으로 간주합니다.\n자세한 내용은 개인정보 처리방침 및 이용약관에서 확인해 보세요.',
  //         style: TextStyle(
  //             fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
  //         textAlign: TextAlign.center,
  //       ),
  //     );

  Widget get _signUp => Container(
    // width: 10,
    height: 54,
    margin: const EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 195),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          // FIXME: minimumSize & maximumSize value doesn't work for some reason
          // minimumSize: const Size(100, 54),
          // maximumSize: const Size(342, 54),
          side: BorderSide(width: 1.5, color: MyColors.systemSoftBlack),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6))),
      // onPressed: () => {sl<NavigationService>().pushNamed('/sign-up')},
      onPressed: () => {},
      child: Text(
        '휴대폰 번호로 시작하기',
        style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: MyColors.systemBlack),
        textAlign: TextAlign.center,
        )
      )
  );

  Widget get _buildDivider => Container(
    height: 18,
    margin: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
    child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Expanded(
            child: Divider(
              color: Colors.grey,
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('간편 로그인', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),)
          ),
          Expanded(
            child: Divider(
              color: Colors.grey,
            )
          ), 
        ],
      ),
  );

  Widget get _buildSignInList {
    Widget button(SignInType type) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                InkWell(
                  onTap: () async => await signInViewModel.signIn(type),
                  child: getSVGImage('assets/icons/icon_${type.name}.svg'),
                ),
            ),
          ],
        );
      // );
    }
    return Container(
      margin: const EdgeInsets.only(left: 45, right: 45, bottom: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: SignInType.values.map((type) => button(type)).toList()
      ),
    );
  }

  Widget getSVGImage(String assetName) {
    final Widget logo = SvgPicture.asset(assetName);
    return logo;
  }

  Widget get _buildFooter => SizedBox(
    height: 22,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
            style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 14)),
            onPressed: () => {},
            child: const Text('아이디 찾기', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ),
        ),
        const Text('|', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextButton(
            style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 14)),
            onPressed: () => {},
            child: const Text('비밀번호 찾기', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ),
        ),
      ],
    ),
  );
}
