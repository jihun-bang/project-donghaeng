import 'dart:async';
import 'dart:developer';

import 'package:donghaeng/data/repository/chat_room_repository.dart';
import 'package:donghaeng/model/chat.dart';
import 'package:donghaeng/view/navigation/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../data/di/locator.dart';
import '../data/repository/chat_repository.dart';

class ChatroomViewModel extends ChangeNotifier {
  final userID = FirebaseAuth.instance.currentUser?.uid;

  final chatroomID = "-N9MFEaBgdhFATRXFDxr"; // todo: for test
  final _chatRepository = sl<ChatRepository>();
  final _chatRoomRepository = sl<ChatRoomRepository>();

  ChatRoom? _chatRoom;

  ChatRoom? get chatRoom => _chatRoom;

  final List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  Map<String, ChatRoom>? chatRooms = {};

  late StreamSubscription<DatabaseEvent> chatUpdates; // todo: close해주기

  ChatroomViewModel() {
    getChatList();
  }

  getChatList() async {
    chatRooms = await _chatRoomRepository.getAllChatRooms();
    notifyListeners();
  }

  joinChatRoom(String chatRoomID, ChatRoom chatRoom) async {
    // 처음 입장
    if (!chatRoom.members.contains(userID)) {
      chatRoom.members.add(userID!);

      try {
        _chatRoomRepository.updateChatRoom(chatRoomID, chatRoom);
      } on FirebaseException catch (e) {
        print("joinChatRoom : FirebaseException ${e.toString()}");
        return;
      } catch (e) {
        print("joinChatRoom : Exception ${e.toString()}");
      }
    }

    // todo: users 정보에 chatroom id 추가하기

    sl<NavigationService>().pushNamed("/chat-room");

    // todo: remove
  }

  List<Chat> getRealtimeChats() {
    getChats(chatroomID);
    return _chats;
  }

  // todo: chatroom id를 parameter로 받기
  void getChatroom() async {
    // todo : 에러처리
    _chatRoom = await _chatRoomRepository.getChatRoom(chatRoomID: chatroomID);
    notifyListeners();
  }

  Future<bool> addChat(String owner, String content) async {
    return await _chatRepository.addChat(
        chatroomID: chatroomID,
        chat: Chat(
            createdAt: DateTime.now().toUtc(),
            owner: owner,
            content: content,
            reader: null));
  }

  void getChats(String chatroomID) {
    chatUpdates = _chatRepository.getChatStream(chatroomID: chatroomID).listen(
      (DatabaseEvent event) {
        final m = Map<String, dynamic>.from(event.snapshot.value as Map);
        _chats.add(Chat.fromJson(m));
        notifyListeners();
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        log(error.toString());
      },
    );
  }
}
