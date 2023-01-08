import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../injection.dart';
import '../navigation/navigation.dart';
import '../provider/sign_up_viewmodel.dart';
import 'package:provider/provider.dart';
// import 'dart:async';
import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final viewModel = sl<SignUpViewModel>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KR';
  PhoneNumber number = PhoneNumber(isoCode: 'KR');
  String? phoneNumberInput = '';
  bool isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (_, __, ___) => Scaffold(
        appBar: SignUpAppbar(value: 0.1),
        body: Column(
            children: <Widget> [
              // _id,
              _numberInput,
              SignUpMainButton(text: '인증번호 발송', phoneNumberInput: phoneNumberInput, isEnabled: isPhoneNumberValid, type: 'verification')
            ]),
        // body: Padding(
        //     padding: const EdgeInsets.only(left: 36, right: 36, top: 8),
        //     child: _id),
      ),
    );
  }

  // Widget get _next => TextButton(
  //     onPressed:
  //         viewModel.loading ? null : () => viewModel.addUser(viewModel.id),
  //     child: viewModel.loading
  //         ? const CircularProgressIndicator()
  //         : const Text(
  //             '다음',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ));

  // Widget get _id => DhTextFormFiled(
  //       label: '아이디',
  //       hint: '영문 소문자, 숫자, 언더바 조합',
  //       enabled: !viewModel.loading,
  //       validator: viewModel.validateId,
  //       onChange: (value) => viewModel.id = value,
  //       onFieldSubmitted: (value) => viewModel.addUser(value),
  //     );

  Widget get _numberInput => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: 
      Form(
        key: formKey,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 45),
              Text ('가입을 위해 휴대폰 번호를 입력해주세요.', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: MyColors.systemBlack)),
              const SizedBox(height: 32),
              Text('휴대폰 번호', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColors.systemGrey_500)),
              _buildPhoneNumberInput,
              const SizedBox(height: 32),
              _buildAgreementInfo,
              // ElevatedButton(onPressed: () => formKey.currentState?.save(), child: const Text('Save')),
            ],
      ),
   ) );

   Widget get _buildAgreementInfo => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildTextInfo('휴대폰 번호를 입력하면 동행의 이용약관에 동의하는 것으로 간주합니다.'),
      Row(
        children: <Widget>[
          _buildTextInfo('자세한 내용은'),
          _buildTextButton('개인정보 처리방침'),
          _buildTextInfo('및'),
          _buildTextButton('이용약관'),
          _buildTextInfo('에서 확인해 주세요.'),
        ],
      )
    ],
   );

   Widget _buildTextInfo(String infoString) => Text(
    infoString,
    style: TextStyle(color: MyColors.systemGrey_500, fontSize: 12)
   );

   Widget _buildTextButton(String buttonString) => TextButton(
    style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 7)),
    onPressed: () => {},
    child: Text(buttonString, style: TextStyle(
                  height: 1.9,
                  shadows: [Shadow(color: MyColors.systemGrey_500, offset: const Offset(0, -1))],
                  color: Colors.transparent,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: MyColors.systemGrey_500
                )),
   );

   Widget get _buildPhoneNumberInput => Stack(
                children: [
                  InternationalPhoneNumberInput(
                    // hintText: '01012345678',
                    hintText: '전화번호',
                    validator: (String? number) {
                      if (!isPhoneNumberValid) {
                      return '전화번호를 확인해주세요.';
                      }
                      return null;
                    },
                    onInputChanged: (PhoneNumber number) {
                      setState(() => phoneNumberInput = number.phoneNumber);
                      // FIXME: only testing if the input number length is greater than 10
                      setState(() => isPhoneNumberValid = number.phoneNumber!.length > 12 ? true : false);
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    // autoValidateMode: AutovalidateMode.always,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: controller,
                    formatInput: false,
                    locale: 'KR',
                    autoFocus: false,
                    keyboardType:
                      const TextInputType.numberWithOptions(signed: true, decimal: true),
                    onSaved: (PhoneNumber number) {
                      print('On Saved: $number');
                    },
                  ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: IconButton(
                      onPressed: () => clearInput(),
                      icon: const Icon(Icons.cancel, size: 16),
                      padding: const EdgeInsets.all(0),
                      color: MyColors.systemGrey_500
                    ),
                  )
                ],
              );

  // FIXME: state 관련
  //  Timer _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) => {});
  //  int _start = 150;

  //  void startTimer() {
  //   _start = 150;
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(oneSec, (Timer timer) {
  //     if (_start == 0) {
  //       setState(() => timer.cancel());
  //     } else {
  //       print(_start);
  //       setState(() => _start--);
  //     }
  //    });
  // }

  // String _showTimer(int time) {
  //   String twoDigits(int n) => n.toString().padLeft(2, "0");
  //   String twoDigitMinutes = twoDigits(Duration(seconds: time).inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(Duration(seconds: time).inSeconds.remainder(60));
  //   print(time);
  //   print(Duration(seconds: time));
  //   print(twoDigitMinutes);
  //   print(twoDigitSeconds);
  //   return '$twoDigitMinutes:$twoDigitSeconds';

  // }

  void clearInput() {
    controller.clear();
    setState((){
      phoneNumberInput = '';
      isPhoneNumberValid = false;
    });
  }

  // void (String phoneNumber) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

  //   setState(() {
  //     this.number = number;
  //   });
  // }

  @override
  void dispose() {
    controller.dispose();
    // _timer.cancel();
    super.dispose();
  }
}