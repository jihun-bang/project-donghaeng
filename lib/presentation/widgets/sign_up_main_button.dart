import 'package:flutter/material.dart';
import 'package:donghaeng/presentation/theme/color.dart';
import 'package:flutter/services.dart';


class SignUpMainButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final String? type;
  final String? phoneNumberInput;
  final VoidCallback? callback; // for onPressed action

  const SignUpMainButton({Key? key, required this.text, this.type, required this.isEnabled, this.phoneNumberInput, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
    child: Column(
      children: <Widget>[
        const Spacer(flex: 1),
        OutlinedButton(
              onPressed:
                !isEnabled ? null : () => {
                  if (type == null) {
                    // null // for now 
                    () => {callback}
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
                child: Text(text,
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
                    Text(phoneNumberInput ?? '',
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
                      icon: const Icon(Icons.refresh, size: 24),
                      color: MyColors.systemSoftBlack),
                ))
              ],
            ),
            const SizedBox(height: 36),
            TextField(
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


