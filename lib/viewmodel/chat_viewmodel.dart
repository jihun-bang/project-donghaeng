import 'dart:convert';

import 'package:donghaeng/model/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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

  void addChat() {
    chats.add(Chat(title: '제목', members: ['a'], tags: ['tag']));
    notifyListeners();
  }
}
