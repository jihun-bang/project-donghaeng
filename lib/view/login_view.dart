import 'package:donghaeng/viewmodel/login_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(primary: Colors.white),
        onPressed: Provider.of<LoginViewModel>(context).signInWithGoogle,
        icon: SvgPicture.asset('assets/icons/icon_google.svg'),
        label: Text(
          'Sign in with Google',
          style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.54),
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
      ),
    );
  }
}
