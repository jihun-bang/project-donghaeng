import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../injection.dart';
import '../../navigation/navigation.dart';

class BirthView extends StatefulWidget {
  const BirthView({
    Key? key,
  }) : super(key: key);

  @override
  State<BirthView> createState() => _BirthViewState();
}

class _BirthViewState extends State<BirthView> {
  String birthDay = '0000/00/00';

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpAppbar(value: 0.4),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      const Text('생일을 알려주세요.',
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
                      Row(children: <Widget>[buildBirthDayTextButton],),
                    ])),
            SignUpMainButton(
              text: '다음',
              isEnabled: birthDay != '0000/00/00',
              callback: () =>
                  sl<NavigationService>().pushNamed("/sign-up/birth"),
            )
          ],
        ));
  }

  Widget get buildBirthDayTextButton {
    var birthDayArray = birthDay.split('');
    return SizedBox(
      height: 70,
      child: OutlinedButton(
          onPressed: () {
            showModalBottomSheet(context: context, builder: (context) => _buildDatePicker);
          }, 
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            side: const BorderSide(color: Colors.transparent)
            ),
          child: Row(
            children: birthDayArray.map(
              (date) => birthDayText(date, birthDay == '0000/00/00' ? true : false)).toList()
          ),
        ),
    );
  }

  Widget birthDayText(String date, bool isDefault) => Container(
    padding: const EdgeInsets.only(right: 5),
    width: 36,
    child: Column(
      children: <Widget>[
        Text(date, style: TextStyle(
          height: 2,
          color: isDefault ? MyColors.systemGrey_400 : MyColors.systemBlack,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),), 
        SizedBox(
          height: 2,
          width: 24,
          child: DecoratedBox(
              decoration:  BoxDecoration(
                color: date != '/' ? MyColors.systemGrey_400 : Colors.transparent
                ),
            ),
          )
      ],
    ),
  );

  Widget get _buildDatePicker => Container(
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
        child: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now(),
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  birthDay = DateFormat('yyyy/MM/dd').format(newDateTime);
                });
              },
            ))));

}
