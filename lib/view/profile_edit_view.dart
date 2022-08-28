import 'package:donghaeng/view/navigation/navigation.dart';
import 'package:donghaeng/view/widget/text_form_filed.dart';
import 'package:donghaeng/viewmodel/sign_up_viewmodel.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/di/locator.dart';
import 'widget/profile_image.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({Key? key}) : super(key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final _signUpViewModel = sl<SignUpViewModel>();
  final _userViewModel = sl<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignUpViewModel, UserViewModel>(
      builder: (_, __, ___, ____) => Scaffold(
          appBar: AppBar(
            title: const Text('프로필 수정'),
            centerTitle: true,
            leading: _cancel,
            actions: [_done],
          ),
          body: _userViewModel.user != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 36, right: 36, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [_image, _name, _description, _instagram],
                  ))
              : const Center(child: CircularProgressIndicator())),
    );
  }

  Widget get _cancel => TextButton(
        child: const Text(
          '취소',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => sl<NavigationService>().pop(),
      );

  Widget get _done => TextButton(
      onPressed:
          _signUpViewModel.loading ? null : () => _signUpViewModel.updateUser(),
      child: _signUpViewModel.loading
          ? const CircularProgressIndicator()
          : const Text(
              '완료',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));

  Widget get _image {
    final userUrl =
        _signUpViewModel.profileImage?.path ?? _userViewModel.user?.imagePath;
    return InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () => _signUpViewModel.getProfileImage(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileImage(url: userUrl),
            ),
            Text(
              '프로필 사진 바꾸기',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.7)),
            )
          ],
        ));
  }

  Widget get _name => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DhTextFormFiled(
          label: '이름',
          hint: '홍길동',
          initValue: _userViewModel.user?.name,
          enabled: !_signUpViewModel.loading,
          onChange: (value) => _signUpViewModel.name = value,
          validator: _signUpViewModel.validateName,
        ),
      );

  Widget get _description => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DhTextFormFiled(
          label: '소개',
          hint: '자기소개를 입력하세요.',
          initValue: _userViewModel.user?.description,
          enabled: !_signUpViewModel.loading,
          onChange: (value) => _signUpViewModel.description = value,
        ),
      );

  Widget get _instagram => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DhTextFormFiled(
          label: 'SNS',
          hint: '@',
          initValue: _userViewModel.user?.instagram,
          enabled: !_signUpViewModel.loading,
          onChange: (value) => _signUpViewModel.instagram = value,
        ),
      );
}
