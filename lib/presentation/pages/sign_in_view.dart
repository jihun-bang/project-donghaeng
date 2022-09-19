import 'package:cached_network_image/cached_network_image.dart';
import 'package:donghaeng/presentation/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            return Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        'assets/images/image_sign_in.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  const Spacer(),
                  _buildInfo,
                  _buildSignInList,
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
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/image_sign_in.png'),
              fit: BoxFit.cover)),
      child: Center(
          child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
              ))));

  Widget get _buildInfo => const Padding(
        padding: EdgeInsets.only(bottom: 28),
        child: Text(
          '로그인 하면 GiGi 이용약관에 동의하는 것으로 간주합니다.\n자세한 내용은 개인정보 처리방침 및 이용약관에서 확인해 보세요.',
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );

  Widget get _buildSignInList {
    Widget button(SignInType type) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.only(left: 18, right: 18),
              backgroundColor: Colors.transparent,
              minimumSize: const Size(300, 60),
              maximumSize: const Size(400, 60),
              side: const BorderSide(width: 2, color: Color(0xFFFEFFFF)),
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
                    '${type.korean} 로그인',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: SignInType.values.map((type) => button(type)).toList()
          ..add(_buildLoginQuestion),
      ),
    );
  }

  Widget get _buildLoginQuestion => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 42),
        child: InkWell(
          onTap: () {},
          child: const Text(
            '로그인이 안되나요?',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
      );
}
