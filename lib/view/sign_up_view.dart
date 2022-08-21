import 'package:donghaeng/view/widget/text_form_filed.dart';
import 'package:donghaeng/viewmodel/sign_up_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/di/locator.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final viewModel = sl<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (_, __, ___) => Scaffold(
        appBar: AppBar(
          leading: _logout,
          actions: [_next],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, top: 8),
            child: _id),
      ),
    );
  }

  Widget get _logout => IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => viewModel.logout(),
      );

  Widget get _next => TextButton(
      onPressed:
          viewModel.loading ? null : () => viewModel.addUser(viewModel.id),
      child: viewModel.loading
          ? const CircularProgressIndicator()
          : const Text(
              '다음',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));

  Widget get _id => DhTextFormFiled(
        label: '아이디',
        hint: '영문 소문자, 숫자, 언더바 조합',
        enabled: !viewModel.loading,
        validator: viewModel.validateId,
        onChange: (value) => viewModel.id = value,
        onFieldSubmitted: (value) => viewModel.addUser(value),
      );
}
