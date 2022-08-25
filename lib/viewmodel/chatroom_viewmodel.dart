import 'dart:convert';
import 'dart:async';

import 'package:donghaeng/data/repository/chat_room_repository.dart';
import 'package:donghaeng/model/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

import '../data/di/locator.dart';
import '../data/repository/chatroom_repository.dart';

class ChatroomViewModel extends ChangeNotifier {
  final chatroomID = "-N9MFEaBgdhFATRXFDxr"; // todo: for test

  final _repository = sl<ChatroomRepository>();
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

Map<String, dynamic> dynamicMapToString(Map<dynamic, dynamic> data) {
  List<dynamic> _convertList(List<dynamic> src) {
    List<dynamic> dst = [];
    for (int i = 0; i < src.length; ++i) {
      if (src[i] is Map<dynamic, dynamic>) {
        dst.add(dynamicMapToString(src[i]));
      } else if (src[i] is List<dynamic>) {
        dst.add(_convertList(src[i]));
      } else {
        dst.add(src[i]);
      }
    }
    return dst;
  }

  Map<String, dynamic> retval = {};
  for (dynamic key in data.keys) {
    if (data[key] is Map<dynamic, dynamic>) {
      retval[key.toString()] = dynamicMapToString(data[key]);
    } else if (data[key] is List<dynamic>) {
      retval[key.toString()] = _convertList(data[key]);
    } else {
      retval[key.toString()] = data[key];
    }
  }
  return retval;
}
