import 'dart:convert';

import 'package:donghaeng/model/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Chatroom> chats = [];

  ChatViewModel() {
    rootBundle.loadString('assets/data/chat.json').then((str) {
      final jsonString = json.decode(str) as List;
      for (final chat in jsonString) {
        chats.add(Chatroom.fromJson(chat));
        notifyListeners();
      }
    });
  }
}

// todo: 위치 옮기기, rename
class ChatroomDataModel {
  late final String chatroomID;
  late final DatabaseReference chatroomRef;

  ChatroomDataModel(String cID) {
    chatroomID = cID;
    chatroomRef = FirebaseDatabase.instance.ref("chatrooms/$chatroomID");
  }

  Future<Chatroom> readChatroom() async {
    final snapshot = await chatroomRef.get();
    if (snapshot.exists) {
      Map<String, dynamic> json = <String, dynamic>{};
      Map<String, dynamic>.from(snapshot.value as Map).forEach((key, value) {
        json[key] = value;
      });

      if (json.containsKey("chats")) {
        json['chats'] =
            Map<String, dynamic>.from(json["chats"] as Map).values.toList();
      } else {
        json['chats'] = null;
      }

      return Chatroom.fromJson(json);
    } else {
      throw 'No data available.';
    }
  }

  addChat(String owner, DateTime createdAt, String content) async {
    final chats = Chat(
        createdAt: createdAt, owner: owner, content: content, reader: null);

    DatabaseReference chatRef = chatroomRef.child("chats");
    final newPostKey = chatRef.push().key;

    await chatRef.child('$newPostKey').set(chats.toJson());
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

createChatroom(String title, String start, String end, String owner) async {
  final chat = Chatroom(
      title: title,
      createdAt: DateTime.now().toUtc(),
      travelDate: TravelDate(start: start, end: end),
      owner: owner,
      members: [owner],
      tags: ["tag1", "tag2"],
      chats: null);

  DatabaseReference ref = FirebaseDatabase.instance.ref("chatrooms");

  final newPostKey = ref.push().key;

  await ref.child('$newPostKey').set(chat.toJson());
}
