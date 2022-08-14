import 'dart:convert';

import 'package:donghaeng/model/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Chat> chats = [];

  ChatViewModel() {
    rootBundle.loadString('assets/data/chat.json').then((str) {
      final jsonString = json.decode(str) as List;
      for (final chat in jsonString) {
        chats.add(Chat.fromJson(chat));
        notifyListeners();
      }
    });
  }
}

createChatRoom(String title, String start, String end, String owner) async {
  final chat = Chat(
      title: title,
      createdAt: DateTime.now().toUtc(),
      travelDate: TravelDate(start: start, end: end),
      owner: owner,
      members: [owner],
      tags: ["tag1", "tag2"],
      chatContents: null);

  DatabaseReference ref = FirebaseDatabase.instance.ref("chatrooms");

  final newPostKey = ref.push().key;

  await ref.child('$newPostKey').set(chat.toJson());
}

addChatContent(String chatId, String owner, String content) async {
  final chatContent = ChatContent(
      createdAt: DateTime.now(), owner: owner, content: content, reader: null);

  DatabaseReference ref =
      FirebaseDatabase.instance.ref("chatrooms/$chatId/chatContents");

  final newPostKey = ref.push().key;

  await ref.child('$newPostKey').set(chatContent.toJson());
}
