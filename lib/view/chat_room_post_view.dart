import 'package:flutter/material.dart';

class ChatRoomPostView extends StatefulWidget {
  const ChatRoomPostView({Key? key}) : super(key: key);

  @override
  State<ChatRoomPostView> createState() => _ChatRoomPostView();
}

class _ChatRoomPostView extends State<ChatRoomPostView> {
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
                TextButton(onPressed: () {}, child: const Text('완료')),
              ],
            ),
          ),
        ),
      );

  Widget get _body => Column(
        children: const <Widget>[
          SizedBox(
            height: 20,
          ),
          TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "제목을 입력해주세요. (20자 이내)",
          )),
          SizedBox(
            height: 20,
          ),
          TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "내용을 입력해주세요. (20자 이내)",
          )),
        ],
      );
}
