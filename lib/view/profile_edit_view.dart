import 'package:donghaeng/view/widget/text_form_filed.dart';
import 'package:donghaeng/viewmodel/sign_up_viewmodel.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/di/locator.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({Key? key}) : super(key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final viewModel = sl<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (_, __, ___) => Scaffold(
        appBar: AppBar(
          title: const Text('프로필 수정'),
          centerTitle: true,
          leading: _cancel,
          actions: [_done],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, top: 8),
            child: Column(
              children: [_name, _description, _instagram],
            )),
      ),
    );
  }

  Widget get _cancel => TextButton(
        child: const Text(
          '취소',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => viewModel.logout(),
      );

  Widget get _done => TextButton(
      onPressed: viewModel.loading ? null : () => viewModel.updateProfile(),
      child: viewModel.loading
          ? const CircularProgressIndicator()
          : const Text(
              '완료',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));

  Widget get _name => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DhTextFormFiled(
          label: '이름',
          hint: '홍길동',
          enabled: !viewModel.loading,
          onChange: (value) => viewModel.name = value,
          validator: viewModel.validateName,
        ),
      );

  Widget get _description => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DhTextFormFiled(
          label: '소개',
          hint: '자기소개를 입력하세요.',
          enabled: !viewModel.loading,
          onChange: (value) => viewModel.description = value,
        ),
      );

  Widget get _instagram => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DhTextFormFiled(
          label: 'SNS',
          hint: '@',
          enabled: !viewModel.loading,
          onChange: (value) => viewModel.instagram = value,
        ),
      );
}
