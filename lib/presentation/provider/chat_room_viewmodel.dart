import 'dart:async';
import 'dart:developer';

import 'package:donghaeng/presentation/provider/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/repositories/chat_room_repository.dart';
import '../../injection.dart';
import '../navigation/navigation.dart';

class ChatroomViewModel extends ChangeNotifier {
  final _userViewModel = sl<UserViewModel>();

  final user = FirebaseAuth.instance.currentUser!;

  final _chatRepository = sl<ChatRepository>();
  final _chatRoomRepository = sl<ChatRoomRepository>();

  ChatRoom? _chatRoom;
  ChatRoom? get chatRoom => _chatRoom;

  final List<Chat> _chats = [];

  Map<String, ChatRoom>? chatRooms = {};

  late StreamSubscription<DatabaseEvent> chatUpdates;

  ChatroomViewModel() {
    getChatList();
  }

  getChatList() async {
    chatRooms = await _chatRoomRepository.getAllChatRooms();
    notifyListeners();
  }

  joinChatRoom(String chatRoomID, ChatRoom chatRoom) async {
    // 처음 입장
    if (!chatRoom.members.contains(user.uid)) {
      chatRoom.members.add(user.uid);

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

    // 이동
    sl<NavigationService>()
        .pushNamed("/chat-room", arguments: {'chatRoomID': chatRoomID});
  }

  List<Chat> getRealtimeChats(String chatRoomID) {
    getChats(chatRoomID);
    return _chats;
  }

  void clearChats() {
    _chats.clear();
  }

  // todo: chatroom id를 parameter로 받기
  void getChatroom(String chatRoomID) async {
    // todo : 에러처리
    _chatRoom = await _chatRoomRepository.getChatRoom(chatRoomID: chatRoomID);
    _userViewModel.getMemberImagePath(memberIDs: _chatRoom?.members);
    notifyListeners();
  }

  Future<bool> addChat(String chatRoomID, String owner, String content) async {
    return await _chatRepository.addChat(
        chatroomID: chatRoomID,
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
