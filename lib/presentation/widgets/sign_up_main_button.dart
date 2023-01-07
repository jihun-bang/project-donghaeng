import 'package:flutter/material.dart';
import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/navigation/navigation.dart';
import '../../injection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpMainButton extends StatefulWidget {
  final String text;
  final bool isEnabled;
  final String? type;
  final String? phoneNumberInput;
  final VoidCallback? callback; // for onPressed action

  const SignUpMainButton({Key? key, required this.text, this.type, required this.isEnabled, this.phoneNumberInput, this.callback}) : super(key: key);

  @override
  State<SignUpMainButton> createState() => _SignUpMainButtonState();
}

class _SignUpMainButtonState extends State<SignUpMainButton> {
  String verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Expanded(
    child: Column(
      children: <Widget>[
        const Spacer(flex: 1),
        OutlinedButton(
              onPressed:
                !widget.isEnabled ? null : () => {
                  if (widget.type == null) {
                    widget.callback!()
                  } else {
                    showModalBottomSheet(context: context, builder: (context) => _buildVerification),
                  }
                  // startTimer()
                }
              ,
              style: OutlinedButton.styleFrom(
                disabledForegroundColor: MyColors.systemGrey_300,
                disabledBackgroundColor: MyColors.systemGrey_300,
                side: const BorderSide(color: Colors.transparent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                backgroundColor: MyColors.systemSoftBlack,
                minimumSize: const Size.fromHeight(100)
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                // child: const Text('인증번호 발송',
                child: Text(widget.text,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ))),
              ) 
      ],
    ));
  }

    Widget get _buildVerification => Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.transparent),
        color: const Color(0xFF757575),
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: _buildCodeInput
      )
    );

    Widget get _buildCodeInput => Padding(
        padding: const EdgeInsets.only(top: 24, right: 28, left: 28),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                Column(
                  children: <Widget>[
                    const Text('인증번호 입력',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(widget.phoneNumberInput ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.systemGrey_500,
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                  ],
                ),
                Expanded(
                    child: Container(
                  height: 60,
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/icon_renew.svg'),
                      color: MyColors.systemSoftBlack),
                ))
              ],
            ),
            const SizedBox(height: 36),
            TextField(
              onChanged: (value) {
                setState(() => verificationCode = value);
                // TODO: 파베쪽 verification code와 비교해서 맞으면 다음 스탭 페이지로 라우팅
                // FIXME: 지금은 일단 6자 채우면 다음 스탭으로 넘어가게 작성
                if (verificationCode.length == 6) {
                  sl<NavigationService>().pushNamed("/sign-up/gender");
                }
              },
              textAlign: TextAlign.center,
              maxLength: 6,
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: '',
                  counterText: '',
                  isCollapsed: true,
                  border: InputBorder.none),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: TextStyle(
                  color: MyColors.systemBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
            const SizedBox(height: 12),
            Text('02:30',
                style: TextStyle(
                    color: MyColors.systemBlack,
                    fontWeight: FontWeight.w400,
                    fontSize: 14))
            // FIXME: state 관련
            // Text(_start.toString(), style: TextStyle(color: MyColors.systemBlack, fontWeight: FontWeight.w400,fontSize: 14))
          ],
        ),
      );
}


