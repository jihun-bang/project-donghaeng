import 'dart:async';
import 'dart:convert';

import 'package:donghaeng/model/chat.dart';
import 'package:donghaeng/view/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import '../viewmodel/chat_viewmodel.dart';

class ChatroomView extends StatefulWidget {
  const ChatroomView({Key? key}) : super(key: key);

  @override
  State<ChatroomView> createState() => _ChatroomViewState();
}

class _ChatroomViewState extends State<ChatroomView> {
  final TextEditingController _textController = TextEditingController();
  late final ChatroomDataModel _chatroomDataModel;
  Future<Chatroom>? chatroom;
  final myID = "junga...id"; // todo: for test

  late Stream<DatabaseEvent> chatsStream;

  _ChatroomViewState() {
    _chatroomDataModel =
        ChatroomDataModel("-N9MFEaBgdhFATRXFDxr"); // todo: for test
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    chatroom = _chatroomDataModel.readChatroom();
    chatsStream = _chatroomDataModel.keepReadChats();
  }

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
                Expanded(
                  child: FutureBuilder(
                      future: chatroom,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Chatroom? chatroom = snapshot.data as Chatroom?;
                          return Center(child: Text(chatroom?.title ?? 'Fail'));
                        } else if (snapshot.hasError) {
                          print('error : chatroom_view : FutureBuilder : ${snapshot.error}');
                          return const Center(child: Text("Fail"));
                        }
                        return const Center(child: Text("loading"));
                      }),
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
          StreamBuilder(
              stream: chatsStream,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  print('StreamBuilder context $context');
                  print('StreamBuilder success ${snapshot.data.toString()}');
                  return const Text("data");
                  // Chatroom? chatroom = snapshot.data as Chatroom?;
                  // return ListView.builder(
                  //   itemCount: chatroom?.chats?.length ?? 0,
                  //   shrinkWrap: true,
                  //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       padding: const EdgeInsets.only(
                  //           left: 16, right: 16, top: 10, bottom: 10),
                  //       child: Align(
                  //         // todo: 사용자 id 받아서 위치 수정하기
                  //         alignment: (chatroom?.chats?[index].owner == myID
                  //             ? Alignment.topRight
                  //             : Alignment.topLeft),
                  //         child: Container(
                  //           constraints: const BoxConstraints(maxWidth: 299),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20),
                  //             border: Border.all(color: Colors.grey.shade200),
                  //             color: (chatroom?.chats?[index].owner == myID
                  //                 ? Colors.grey.shade200
                  //                 : Colors.white),
                  //           ),
                  //           padding: const EdgeInsets.all(16),
                  //           child: Text(
                  //             '${chatroom?.chats?[index].owner} = ${chatroom?.chats?[index].content}',
                  //             style: const TextStyle(fontSize: 15),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                } else if (snapshot.hasError) {
                  print('error : chatroom_view : StreamBuild : ${snapshot.error}');
                }
                return const Center(child: Text("loading"));
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    // todo : 정해지면 수정
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
    _chatroomDataModel.addChat(myID, DateTime.now(), text);

    _textController.clear();
  }
}

// // read data
// Future<Chatroom> dbChat = _chatroomDataModel.readChatroom();
// dbChat.then((value) => {print(value.toString())}).catchError((error) {
// print(error);
// });

// todo: 원형 표시 - 프로필
// const CircleAvatar(
// backgroundImage: NetworkImage(
// "<https://randomuser.me/api/portraits/men/5.jpg>"),
// maxRadius: 20,
// ),
