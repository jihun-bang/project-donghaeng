import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../injection.dart';
import '../navigation/navigation.dart';
import '../provider/sign_up_viewmodel.dart';
import '../provider/user_viewmodel.dart';
import '../widgets/profile_image.dart';
import '../widgets/text_form_filed.dart';

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
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _image,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [_name, _description, _instagram],
                        ),
                      )
                    ],
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
    final profileUrl =
        _signUpViewModel.profileImage?.path ?? _userViewModel.user?.imagePath;
    final backgroundUrl = _signUpViewModel.backgroundImage?.path ??
        _userViewModel.user?.backgroundImagePath;
    final textColor = profileUrl != null ? Colors.white : Colors.black;

    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      alignment: Alignment.center,
      decoration: backgroundUrl != null
          ? BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(backgroundUrl),
                  fit: BoxFit.cover))
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProfileImage(url: profileUrl),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () => _signUpViewModel.getProfileImage(),
            child: Text(
              '프로필 사진 바꾸기',
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          _backgroundImage(backgroundUrl != null)
        ],
      ),
    );
  }

  Widget _backgroundImage(bool hasUrl) {
    final textColor = hasUrl ? Colors.white : Colors.black;

    return InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () => _signUpViewModel.getProfileImage(isProfile: false),
        child: Text(
          '프로필 배경 바꾸기',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ));
  }

  Widget get _name => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
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
