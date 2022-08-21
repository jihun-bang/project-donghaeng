import 'dart:convert';
import 'dart:async';

import 'package:donghaeng/model/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

import '../data/di/locator.dart';
import '../data/repository/chatroom_repository.dart';

class ChatroomViewModel extends ChangeNotifier {
  final chatroomID = "-N9MFEaBgdhFATRXFDxr"; // todo: for test

  final _repository = sl<ChatroomRepository>();

  Chatroom? _chatroom;
  Chatroom? get chatroom => _chatroom;

  final List<Chatroom> chats = [];

  ChatroomViewModel() {
    rootBundle.loadString('assets/data/chat.json').then((str) {
      final jsonString = json.decode(str) as List;
      for (final chat in jsonString) {
        chats.add(Chatroom.fromJson(chat));
        notifyListeners();
      }
    });
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
  Stream<DatabaseEvent> getChats() {
    return _repository.getChats(chatroomID: chatroomID);
  }
}

// todo: 위치 옮기기, rename
class ChatroomDataModel {
  late final String chatroomID;
  late final DatabaseReference chatroomsRef;
  late final DatabaseReference chatsRef;

  ChatroomDataModel(String cID) {
    chatroomID = cID;
    chatroomsRef = FirebaseDatabase.instance.ref("chatrooms/$chatroomID");
    chatsRef = chatroomsRef.child("chats");
  }

  // todo : rename
  // Stream<DatabaseEvent> keepReadChats() {
  //   final chatsQuery = chatsRef.limitToLast(10);
  //
  //   return chatsQuery.onChildAdded.listen(
  //     (DatabaseEvent event) {
  //       print('Child added: ${event.snapshot.value}');
  //     },
  //     onError: (Object o) {
  //       final error = o as FirebaseException;
  //       print('Error: ${error.code} ${error.message}');
  //     },
  //   );
  // }

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

createChatroom(String title, String start, String end, String owner) async {
  final chat = Chatroom(
      title: title,
      createdAt: DateTime.now().toUtc(),
      travelDate: TravelDate(start: start, end: end),
      owner: owner,
      members: [owner],
      tags: ["tag1", "tag2"],
      chats: null);

  await FirebaseDatabase.instance.ref("chatrooms").push().set(chat.toJson());
}
