import 'dart:convert';
import 'dart:async';

import 'package:donghaeng/data/repository/chat_room_repository.dart';
import 'package:donghaeng/model/chat.dart';
import 'package:donghaeng/view/navigation/navigation.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/di/locator.dart';
import '../data/repository/chatroom_repository.dart';

class ChatroomViewModel extends ChangeNotifier {
  final userID = FirebaseAuth.instance.currentUser?.uid;

  final chatroomID = "-N9MFEaBgdhFATRXFDxr"; // todo: for test
  final _repository = sl<ChatroomRepository>(); // todo : remove
  final _chatRoomRepository = sl<ChatRoomRepository>();

  Chatroom? _chatroom;

  Chatroom? get chatroom => _chatroom;

  List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  Map<String, ChatRoom>? chatRooms = {};

  ChatroomViewModel() {
    getChatList();
  }

  getChatList() async {
    chatRooms = await _chatRoomRepository.getAllChatRooms();
    notifyListeners();
  }

  joinChatRoom(String chatRoomID, ChatRoom chatRoom) async {
    print("join chat room");

    // 처음 입장
    if (!chatRoom.members.contains(userID)) {
      chatRoom.members.add(userID!);

      try {
        await _chatRoomRepository.updateChatRoom(chatRoomID, chatRoom);
      } on FirebaseException catch (e) {
        print("joinChatRoom : FirebaseException ${e.toString()}");
        return;
      } catch (e) {
        print("joinChatRoom : Exception ${e.toString()}");
      }
    }

    // todo: users 정보에 chatroom id 추가하기

    sl<NavigationService>().pushNamed("/chat-room");
  }

  List<Chat> getRealtimeChats() {
    getChats();
    return _chats;
  }

  // todo: chatroom id를 parameter로 받기
  Future<Chatroom?> getChatroom() async {
    _chatroom = await _repository.getChatroom(chatroomID: chatroomID);
    notifyListeners();
    return _chatroom;
  }

  Future<bool> addChat(String owner, String content) async {
    return await _repository.addChat(
        chatroomID: chatroomID,
        chat: Chat(
            createdAt: DateTime.now().toUtc(),
            owner: owner,
            content: content,
            reader: null));
  }

  // todo: chatroom id를 parameter로 받기
  void getChats() {
    _repository.getChats(chatroomID: chatroomID).listen(
      (DatabaseEvent event) {
        final m = Map<String, dynamic>.from(event.snapshot.value as Map);
        _chats.add(Chat.fromJson(m));
        notifyListeners();
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        print('Error: ${error.code} ${error.message}');
      },
    );
  }
}
