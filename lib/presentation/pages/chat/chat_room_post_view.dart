import 'package:donghaeng/domain/resource/country.dart';
import 'package:donghaeng/presentation/provider/chat_room_viewmodel.dart';
import 'package:donghaeng/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../injection.dart';
import '../../theme/color.dart';

class ChatRoomPostView extends StatefulWidget {
  const ChatRoomPostView({Key? key}) : super(key: key);

  @override
  State<ChatRoomPostView> createState() => _ChatRoomPostView();
}

class _ChatRoomPostView extends State<ChatRoomPostView> {
  // todo: color 부분으로 옮기기
  static const colorPrimary = Color(0xffff8266);
  static const colorLine = Color(0xffEBEBEB);

  final _chatRoomViewModel = sl<ChatRoomViewModel>();

  final cities = ["자그레브", "두브로브니크", "스플리트", "자다르"];

  _chatRoomPost data = _chatRoomPost();

  @override
  void dispose() {
    data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  Widget get _view => Scaffold(
        appBar: _appBar,
        body: _body,
        bottomSheet: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  print(data.step);
                  print(data.titleController.text);
                  print(data.travelDate);
                  print(data.city);
                  print(data.contentController.text);
                  print(data.allowSwitch);
                  print(data.questionController.text);
                  //       if (travelDate != null &&
                  //           country != null &&
                  //           _titleController.text != "") {
                  //         _chatRoomViewModel.addChatRoom(
                  //             title: _titleController.text,
                  //             travelDate: travelDate,
                  //             country: country);
                  //         Navigator.pop(context);
                  //       } else {
                  //         showToast(message: "잘못된 값이 입력됐습니다.");
                  //       }
                },
                child: const Text('다음'),
              ),
            ),
          ),
        ),
      );

  PreferredSizeWidget get _appBar => AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                ),
                // todo:  완료 함수
                // TextButton(
                //     onPressed: () {

                //     },
                //     child: const Text('완료')),
              ],
            ),
          ),
        ),
      );

  Widget get _body => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            if (data.step >= 1) _titleEditor,
            if (data.step >= 2) _travelDatePicker,
            if (data.step >= 2) _line,
            if (data.step >= 2) _cityPicker,
            if (data.step >= 2) _line,
            if (data.step >= 3) _contentEditor,
            if (data.step >= 3) _line,
            if (data.step >= 4) _allowChecker,
            if (data.step >= 4 && data.allowSwitch) _questionEditor,
          ],
        ),
      );

  Widget get _line => const SizedBox(
      width: double.infinity, child: Divider(color: colorLine, thickness: 1.0));

  Widget get _titleEditor => Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            data.checkStep();
          });
        },
        child: TextField(
            controller: data.titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorPrimary),
              ),
              hintText: "어떤 동행을 구해볼까요?",
            )),
      );

  Widget get _travelDatePicker => SizedBox(
        height: 52,
        child: TextButton(
            onPressed: () {
              showDateRangePickerPop();
            },
            child: Center(
                child: Row(children: const <Widget>[
              Icon(
                Icons.calendar_today_outlined,
              ),
              Text('날짜'),
            ]))),
      );

  void showDateRangePickerPop() async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
      saveText: '확인',
      builder: (BuildContext context, Widget? child) {
        return Column(children: [
          ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: 500.0, maxHeight: 600.0),
            child: Theme(data: ThemeData.light(), child: child!),
          ),
        ]);
      },
    );

    if (result != null) {
      setState(() {
        data.travelDate = result;
      });
    }
  }

  Widget get _cityPicker => SizedBox(
        height: 52,
        child: TextButton(
            onPressed: () {
              showCityBottomSheetPop();

              setState(() {
                data.checkStep();
              });
            },
            child: Center(
                child: Row(children: const <Widget>[
              Icon(
                Icons.location_on_outlined,
              ),
              Text('도시'),
            ]))),
      );

  void showCityBottomSheetPop() async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                '도시 선택',
                style: TextStyle(fontSize: 27.29),
                textAlign: TextAlign.left,
              ),
              const Icon(Icons.search),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: cities.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        data.city = cities[index];
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.flag_circle),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                cities[index],
                                style: const TextStyle(fontSize: 23),
                              ),
                              const Text(
                                '크로아티아',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        );
      },
    );
  }

  Widget get _contentEditor => Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            data.checkStep();
          });
        },
        child: SizedBox(
          height: 220,
          child: TextField(
              controller: data.contentController,
              maxLines: null,
              maxLength: 80,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "예) 하고 싶은 활동, 동행을 구하는 이유 등 내용을 자세히 작성할수록 신청률이 높아져요.",
                hintMaxLines: 10,
              )),
        ),
      );

  Widget get _allowChecker => SizedBox(
        height: 52,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.check),
                Text('승인 후 참여'),
              ],
            ),
            Switch(
                value: data.allowSwitch,
                activeColor: colorPrimary,
                onChanged: (bool value) {
                  setState(() {
                    data.allowSwitch = value;
                  });
                }),
          ],
        ),
      );

  Widget get _questionEditor => TextField(
      controller: data.questionController,
      maxLength: 80,
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: "미래의 동행에게 질문을 남겨보세요.",
      ));
}

class _chatRoomPost {
  int step = 1;

  final TextEditingController titleController = TextEditingController();
  DateTimeRange? travelDate;
  String? city = "";
  final TextEditingController contentController = TextEditingController();
  bool allowSwitch = false;
  final TextEditingController questionController = TextEditingController();

  void dispose() {
    titleController.dispose();
    contentController.dispose();
    questionController.dispose();
  }

  void checkStep() {
    switch (step) {
      case 1:
        if (titleController.text.isNotEmpty) {
          step++;
        }
        break;
      case 2:
        if (travelDate != null && city != null) {
          step++;
        }
        break;
      case 3:
        if (contentController.text.isNotEmpty) {
          step++;
        }
        break;
    }
  }
}
