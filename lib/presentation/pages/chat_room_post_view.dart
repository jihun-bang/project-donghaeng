import 'package:donghaeng/domain/resource/country.dart';
import 'package:donghaeng/presentation/provider/chat_room_viewmodel.dart';
import 'package:donghaeng/utils/toast.dart';
import 'package:flutter/material.dart';

import '../../injection.dart';
import '../theme/color.dart';

class ChatRoomPostView extends StatefulWidget {
  const ChatRoomPostView({Key? key}) : super(key: key);

  @override
  State<ChatRoomPostView> createState() => _ChatRoomPostView();
}

class _ChatRoomPostView extends State<ChatRoomPostView> {
  final _chatRoomViewModel = sl<ChatRoomViewModel>();
  String? country;
  DateTimeRange? travelDate;
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  Widget get _view => Scaffold(
        appBar: _appBar,
        body: _body,
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
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Expanded(child: Center(child: Text('채팅방 만들기'))),
                TextButton(
                    onPressed: () {
                      if (travelDate != null &&
                          country != null &&
                          _titleController.text != "") {
                        _chatRoomViewModel.addChatRoom(
                            title: _titleController.text,
                            travelDate: travelDate,
                            country: country);
                        Navigator.pop(context);
                      } else {
                        showToast(message: "잘못된 값이 입력됐습니다.");
                      }
                    },
                    child: const Text('완료')),
              ],
            ),
          ),
        ),
      );

  Widget get _body => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _countryDropdownButton,
                _travelDatePicker,
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "제목을 입력해주세요. (20자 이내)",
                )),
            const SizedBox(
              height: 20,
            ),
            const TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "내용을 입력해주세요. (20자 이내)",
            )),
          ],
        ),
      );

  void showDateRangePickerPop() async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
      saveText: '완료',
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
        travelDate = result;
      });
    }
  }

  String getTravelDateString(DateTimeRange? dateTimeRange) {
    if (dateTimeRange == null) {
      return 'YYYY.MM.DD';
    }

    return '${dateTimeRange.start.toString().split(' ')[0]} - ${dateTimeRange.end.toString().split(' ')[0]}';
  }

  Widget get _travelDatePicker => Expanded(
        child: TextButton(
            onPressed: () {
              showDateRangePickerPop();
            },
            child: Center(
                child: Row(children: <Widget>[
              Icon(
                Icons.calendar_today,
                color: MyColors.grey_1,
              ),
              Center(
                child: Text(
                  getTravelDateString(travelDate),
                  style: TextStyle(color: MyColors.grey_1),
                ),
              )
            ]))),
      );

  Widget get _countryDropdownButton => Expanded(
        child: DropdownButton<String>(
          value: country,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 16,
          hint: const Center(child: Text("나라 선택")),
          style: TextStyle(color: MyColors.grey_1),
          underline: Container(
            height: 2,
            color: MyColors.grey_3,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              country = value!;
            });
          },
          items: Country.values
              .map((e) => e.korean)
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );
}
