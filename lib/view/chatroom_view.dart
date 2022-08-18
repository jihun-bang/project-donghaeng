import 'package:donghaeng/model/chat.dart';
import 'package:donghaeng/view/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';

import '../viewmodel/chat_viewmodel.dart';

class ChatroomView extends StatefulWidget {
  const ChatroomView({Key? key}) : super(key: key);

  @override
  State<ChatroomView> createState() => _ChatroomViewState();
}

class _ChatroomViewState extends State<ChatroomView> {
  final TextEditingController _textController = TextEditingController();
  final ChatroomDataModel _chatroomDataModel =
      ChatroomDataModel("-N9MFEaBgdhFATRXFDxr");

  // todo: 임시 데이터 -> db 데이터로 수정
  List<Chat> chatMessages = [
    Chat(
        createdAt: DateTime.now(), owner: "chera", content: "hi", reader: null),
    Chat(
        createdAt: DateTime.now(),
        owner: "yg.h",
        content: "hi_222",
        reader: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                const Expanded(
                  child: Center(child: Text("채팅 제목!")),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: chatMessages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: Text(
                    '${chatMessages[index].owner} = ${chatMessages[index].content}'),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector( // todo : 정해지면 수정
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (text) {
                        sendMessage(text);
                      },
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sendMessage(_textController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      // Foreground color
                      onPrimary: Theme.of(context).colorScheme.onPrimary,
                      // Background color
                      primary: const Color(0x127287EA), // 배경색
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20), // 사이즈
                      shape: const StadiumBorder(),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    child: const Text(
                      "SEND",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7287EA)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  sendMessage(String text) {
    setState(() {
      chatMessages.add(Chat(
          createdAt: DateTime.now().toUtc(),
          owner: "junga",
          content: text,
          reader: null));
    });

    // _chatroomDataModel.addChat("junga...id", DateTime.now(), text);

    _textController.clear();

    _chatroomDataModel.readChatroom(); //todo: remove_test
  }
}

// todo: 원형 표시 - 프로필
// const CircleAvatar(
// backgroundImage: NetworkImage(
// "<https://randomuser.me/api/portraits/men/5.jpg>"),
// maxRadius: 20,
// ),
