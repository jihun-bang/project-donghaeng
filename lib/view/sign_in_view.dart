import 'package:donghaeng/view/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
                const Text(
                  '동행',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: GoogleSignInButton(
                        clientId: dotenv.env['GOOGLE_CLIENT_ID']!)),
              ],
            );
          } else {
            return const BaseView();
          }
        },
      ),
    );
  }
}
