import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection.dart';
import '../../provider/chat_room_viewmodel.dart';
import '../../provider/user_viewmodel.dart';
import '../../widgets/profile_image.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({Key? key}) : super(key: key);

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class SendChatController extends TextEditingController {
  final _chatRoomViewModel = sl<ChatRoomViewModel>();

  sendChat(String chatRoomID, String userUID) {
    if (text != "") {
      _chatRoomViewModel.addChat(chatRoomID, userUID, text);
      clear();
    }
  }
}

class _ChatRoomViewState extends State<ChatRoomView> {
  final _chatRoomViewModel = sl<ChatRoomViewModel>();
  final _userViewModel = sl<UserViewModel>();

  final User user = FirebaseAuth.instance.currentUser!;
  String _chatRoomID = "";

  final _textController = SendChatController();
  final _focusNode = FocusNode();

  final _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 300), curve: Curves.easeIn);
  }

  bool _isLoadChatData = false;
  bool _isFirstBuildList = true;

  @override
  void initState() {
    super.initState();
    _loadChatRoomID();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();

    _chatRoomViewModel.clearChats();
    _chatRoomViewModel.cancelRealtimeChats();

    super.dispose();
  }

  // chat room id를 메모리에서 불러옴
  Future<void> _loadChatRoomID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _chatRoomID = prefs.getString('chatRoomID') ?? "";
    });
  }

  // chat room id를 메모리에 저장
  Future<void> _saveChatRoomID(String chatRoomID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("chatRoomID", chatRoomID);
  }

  void loadChatData() {
    if (!_isLoadChatData) {
      _isLoadChatData = true;
      _chatRoomViewModel.getChatroomImage(_chatRoomID);
      _chatRoomViewModel.getRealtimeChats(_chatRoomID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (arguments.isNotEmpty) {
      final id = arguments['chatRoomID'];
      _chatRoomID = id;
      _saveChatRoomID(id);
    }

    if (_chatRoomID == "") {
      return const Text("잘못된 접근입니다");
    }

    loadChatData();

    if (_chatRoomViewModel.chatRoom != null &&
        !_chatRoomViewModel.chatRoom!.isMember(user.uid)) {
      return const Text("잘못된 접근입니다2");
    }

    return Consumer2<ChatRoomViewModel, UserViewModel>(
      builder: (_, __, ___, ____) {
        log('build chat_room_view');
        return Scaffold(
          appBar: _appBar,
          body: Column(
            children: <Widget>[
              _chats,
              _sendBar,
            ],
          ),
        );
      },
    );
  }

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
                Expanded(
                    child: Center(
                        child: Text(
                            _chatRoomViewModel.chatRoom?.title ?? 'loading'))),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get _chats => Expanded(
        child: ListView.builder(
            itemCount: _chatRoomViewModel.chats.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            controller: _scrollController,
            itemBuilder: (context, index) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_isFirstBuildList) {
                  scrollDown();
                  if (_chatRoomViewModel.chats.length - 1 == index) {
                    _isFirstBuildList = false;
                  }
                }

                if (_chatRoomViewModel.chats.length - 1 == index) {
                  scrollDown();
                }
              });

              final chat = _chatRoomViewModel.chats[index];
              final isMine = chat.owner == user.uid;
              final image = _userViewModel.userImagePathMap[chat.owner];

              return Row(
                  mainAxisAlignment: (isMine
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start),
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 12, top: 10, bottom: 10),
                        child:
                            isMine ? null : ProfileImage(url: image, size: 40)),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 299),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                          color:
                              (isMine ? const Color(0xffFE7FA8) : Colors.white),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          chat.content,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ]);
            }),
      );

  Widget get _sendBar => Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          height: 76,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  onSubmitted: (text) {
                    _textController.sendChat(_chatRoomID, user.uid);
                    _focusNode.requestFocus();
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
                  _textController.sendChat(_chatRoomID, user.uid);
                },
                style: ElevatedButton.styleFrom(
                  // Foreground color
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  // Background color
                  primary: const Color(0xFF7287EA).withOpacity(0.12), // 배경색
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 20), // 사이즈
                  shape: const StadiumBorder(),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                child: const Text(
                  "전송",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff7287EA)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      );
}
