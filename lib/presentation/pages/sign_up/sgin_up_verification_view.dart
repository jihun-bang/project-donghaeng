import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:donghaeng/presentation/theme/color.dart';
import '../../../injection.dart';
import '../../provider/sign_up_viewmodel.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({Key? key}) : super(key: key);

  @override
  State<VerificationView> createState() => _VericiationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final signUpViewModel = sl<SignUpViewModel>;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (context, snapshot) {
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
                    //_buildPhoneInput,
                  ]),
                )
              ],
            ),
          );
        })
    );
  }
}