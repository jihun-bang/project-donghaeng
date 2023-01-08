import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../injection.dart';
import '../../navigation/navigation.dart';

class NicknameView extends StatefulWidget {
  const NicknameView({
    Key? key,
  }) : super(key: key);

  @override
  State<NicknameView> createState() => _NicknameViewState();
}

class _NicknameViewState extends State<NicknameView> {
  late TextEditingController _controller;
  String nickname = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpAppbar(value: 0.6),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      const Text('닉네임을 정해주세요.',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      const SizedBox(height: 70),
                      Text('닉네임',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.systemGrey_500)),
                      Stack(
                        children: [
                          TextField(
                            maxLength: 14,
                            textCapitalization:  TextCapitalization.characters,
                            controller: _controller,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣 ]")),],
                            onChanged: (value) => setState(() => {
                              _controller.value = TextEditingValue(
                                text: value.toUpperCase(),
                                selection: _controller.selection
                              ),
                              nickname = value.toUpperCase(),
                            }),
                            style: TextStyle(color: MyColors.systemBlack, fontSize: 20, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '닉네임',
                              hintStyle: TextStyle(color: MyColors.systemGrey_400, fontSize: 20, fontWeight: FontWeight.w500),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: nickname != '' ? MyColors.primeOrange : MyColors.systemGrey_400, width: 2 ),),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.primeOrange, width: 2),),
                              errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.systemError, width: 2)),
                              //TODO: need duplication validation
                              // errorText: '이미 사용중인 닉네임입니다.'
                            ),
                            ),
                          Positioned(
                          right: 0,
                          top: 5,
                          child: IconButton(
                            onPressed: () => {
                              _controller.clear(),
                              setState(() {
                                nickname = '';}
                              )},
                            icon: const Icon(Icons.cancel, size: 16),
                            padding: const EdgeInsets.all(0),
                            color: MyColors.systemGrey_500
                          ),
                          )
                        ],
                      ),
                    ])),
            SignUpMainButton(
              text: '다음',
              isEnabled: nickname != '' && nickname.length > 2, //FIXME: && nickname is not duplicate
              callback: () =>
                  sl<NavigationService>().pushNamed("/sign-up/profile"),
            )
          ],
        ));
  }

}
