import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:flutter/material.dart';
import '../../../injection.dart';
import '../../navigation/navigation.dart';

class GenderView extends StatefulWidget {
  const GenderView({Key? key,}) : super(key: key);

  @override
  State<GenderView> createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignUpAppbar(value: 0.2),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
             const SizedBox(height: 45),
             const Text('성별을 선택해주세요.',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
              const SizedBox(height: 10),
              const Text('프로필에 보여집니다.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
              const SizedBox(height: 46),
              SizedBox(
                height: 54,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 1.5,
                      color: gender == '여성' ? MyColors.primeOrange : MyColors.systemGrey_400,
                      ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )
                  ),
                  onPressed: () => {setState(() => gender = '여성')},
                  child: Text('여성',
                    style: TextStyle(color: gender == '여성' ? MyColors.primeOrange : MyColors.systemGrey_400,)
                  )
                )),
              const SizedBox(height: 20),
              SizedBox(
                height: 54,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    
                    side: BorderSide(
                      width: 1.5,
                      color: gender == '남성'
                          ? MyColors.primeOrange
                          : MyColors.systemGrey_400,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
                  onPressed: () => {setState(() => gender = '남성')},
                  child: Text('남성',
                    style: TextStyle(color: gender == '남성' ? MyColors.primeOrange : MyColors.systemGrey_400,)
                  )),
                ),
            ]
          )
        ),
        SignUpMainButton(text: '다음', isEnabled: gender is String, callback: () => {sl<NavigationService>().pushNamed("/sign-up/birth")},)
      ],)
    );
  }
}