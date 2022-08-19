import 'package:donghaeng/view/base_view.dart';
import 'package:donghaeng/view/widget/text_form_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/di/locator.dart';
import '../viewmodel/user_viewmodel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final viewModel = sl<UserViewModel>();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => viewModel.logout(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                viewModel
                    .addUser(textController.text)
                    .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BaseView()),
                        ));
              },
              child: const Text(
                '다음',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 36, right: 36, top: 8),
          child: DhTextFormFiled(
            controller: textController,
            label: '아이디',
            hint: '영문, 숫자, 언더바 조합',
          )),
    );
  }
}
