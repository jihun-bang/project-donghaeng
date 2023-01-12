import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../injection.dart';
import '../../navigation/navigation.dart';
import '../../../data/constants.dart' as constants;

class MBTIView extends StatefulWidget {
  const MBTIView({
    Key? key,
  }) : super(key: key);

  @override
  State<MBTIView> createState() => _MBTIViewState();
}

class _MBTIViewState extends State<MBTIView> {
  final TextEditingController textEditingController = TextEditingController();

  String birthDay = '0000/00/00';
  String? selectedMBTI;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpAppbar(value: 0.9),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      const Text('동행러님의 \nMBTI를 알려주세요.',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      const SizedBox(height: 52),
                      Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: selectedMBTI == null ? MyColors.systemGrey_300 : MyColors.primeOrange, width: 2))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  selectedMBTI == null ? 
                                  Text('MBTI', style: TextStyle(fontSize: 20, color: MyColors.systemGrey_400, fontWeight: FontWeight.w500))
                                  : Text(selectedMBTI!, style: TextStyle(
                                    color: MyColors.systemBlack,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                  )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.keyboard_arrow_down_outlined,
                                          size: 24,
                                          color: MyColors.systemSoftBlack),
                                      const SizedBox(width: 12)
                                    ],
                                  )
                                ],
                              )
                            ),
                            selectedItemHighlightColor: MyColors.primeOrange_200,
                            focusColor: MyColors.primeOrange_200,
                            isExpanded: true,
                            dropdownMaxHeight:
                                MediaQuery.of(context).size.height / 2.5,
                            value: selectedMBTI,
                            items: constants.mbtiList.map((mbti) => DropdownMenuItem<String>(value: mbti, child: Text(mbti, style: TextStyle(color: MyColors.systemBlack, fontSize: 20)))).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMBTI = value.toString();
                              });
                            },
                            searchController: textEditingController,
                            searchInnerWidget: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 4, right: 8, left: 8),
                              child: TextFormField(
                                autofocus: true,
                                controller: textEditingController,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyColors.systemGrey_400,
                                        // color: selectedMBTI != null
                                        //     ? MyColors.primeOrange
                                        //     : MyColors.systemGrey_400,
                                        width: 2),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: MyColors.systemGrey_400, width: 2),
                                    // borderSide: BorderSide(color: MyColors.primeOrange, width: 2),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.systemError, width: 2)),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  hintText: '검색',
                                  hintStyle: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {textEditingController.clear();}
                            },
                            offset: const Offset(0, -10),
                            dropdownElevation: 8,
                          ))
                      )
                    ])),
            SignUpMainButton(
              text: '다음',
              isEnabled: selectedMBTI != null,
              callback: () =>
                  sl<NavigationService>().pushNamed("/home"),
            )
          ],
        ));
  }

}
