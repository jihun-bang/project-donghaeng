import 'package:donghaeng/presentation/widgets/profile_image.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../injection.dart';
import '../../navigation/navigation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final ImagePicker _picker = ImagePicker();
  XFile? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpAppbar(value: 0.6),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      const Text('프로필 사진을 설정해주세요.',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      const SizedBox(height: 70),
                      Center(
                        child: InkWell(
                          onTap: () => {
                            showModalBottomSheet(context: context, builder: ((builder) => uploadBottomSheet()))
                          },
                          child: profileImage == null ? SvgPicture.asset('assets/icons/icon_profile_add.svg') : CircleAvatar(
                              backgroundImage: NetworkImage(profileImage!.path),
                              radius: 60,
                              // maxRadius: 60,
                              // minRadius: 60,
                            ),
                        ) 
                      )
                    ])),
            SignUpMainButton(
              text: '다음',
              isEnabled: profileImage != null,
              isSkippable: true,
              nextStepRoute: 'preferred_countries',
              // FIXME: 프로필 사진 업로드 추가 필요
              callback: () =>
                  sl<NavigationService>().pushNamed("/sign-up/preferred_countries"),
            )
          ],
        ));
  }

  void takePhoto() async {
    final res = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      profileImage = res;
      Navigator.pop(context);
    });
  }

  void pickPhoto() async {
    final res = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImage = res;
      Navigator.pop(context);
    });
  }
  

  Widget uploadBottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
          children: <Widget>[
            const Text(
              "프로필 사진 선택",
              style: TextStyle(
                fontSize:  20,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_rounded),
                    onPressed: () {
                      takePhoto();
                    }
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    pickPhoto();
                  }
                ),
              ],
            )
          ],
      )
    );
  }
}
