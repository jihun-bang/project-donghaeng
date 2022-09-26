import 'dart:async';
import 'dart:developer';

import 'package:donghaeng/presentation/provider/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/repositories/chat_room_repository.dart';
import '../../injection.dart';
import '../navigation/navigation.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final _userViewModel = sl<UserViewModel>();

  final user = FirebaseAuth.instance.currentUser!;

  final _chatRepository = sl<ChatRepository>();
  final _chatRoomRepository = sl<ChatRoomRepository>();

  ChatRoom? _chatRoom;
  ChatRoom? get chatRoom => _chatRoom;

  final List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  Map<String, ChatRoom> publicChatRooms = {};

  Map<String, ChatRoom> myChatRooms = {};
  Map<String, StreamSubscription<DatabaseEvent>> myChats = {};

  late StreamSubscription<DatabaseEvent> chatUpdates;

  ChatRoomViewModel() {
    getChatList();
  }

  getChatList() async {
    final chatRooms = await _chatRoomRepository.getAll();
    if (chatRooms != null) {
      chatRooms.forEach((chatRoomID, chatRoom) {
        // 오픈 채팅방 목록 추가
        // todo: 오픈채팅방인지 확인하는 기능 추가
        publicChatRooms[chatRoomID] = chatRoom;

        // 자신의 채팅방 목록 추가
        if (chatRoom.isMember(user.uid)) {
          addToMyChat(chatRoomID, chatRoom);
        }
      });
    }

    notifyListeners();
  }

  void addToMyChat(String chatRoomID, ChatRoom chatRoom) {
    myChatRooms[chatRoomID] = chatRoom;
    // myChats[chatRoomID] = getChatStream(chatRoomID);
  }

  // StreamSubscription<DatabaseEvent> getChatStream(String chatRoomID) {
  //   return _chatRepository.getChatStream(id: chatRoomID).listen(
  //     (DatabaseEvent event) {
  //       final m = Map<String, dynamic>.from(event.snapshot.value as Map);
  //       // _chats.add(Chat.fromJson(m));
  //       // notifyListeners();
  //     },
  //     onError: (Object o) {
  //       final error = o as FirebaseException;
  //       log(error.toString());
  //     },
  //   );
  // }

  void getRealtimeChats(String chatRoomID) {
    chatUpdates = _chatRepository.getChatStream(id: chatRoomID).listen(
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

  void cancelRealtimeChats() {
    chatUpdates.cancel();
  }

  joinChatRoom(String chatRoomID) async {
    final chatRoom = publicChatRooms[chatRoomID];

    // 처음 입장
    if (!chatRoom!.members.contains(user.uid)) {
      chatRoom.members.add(user.uid);

      try {
        _chatRoomRepository.update(chatRoomID, chatRoom);
      } on FirebaseException catch (e) {
        print("joinChatRoom : FirebaseException ${e.toString()}");
        return;
      } catch (e) {
        print("joinChatRoom : Exception ${e.toString()}");
      }
    }

    if (_userViewModel.user?.addChatRoomID(chatRoomID) ?? false) {
      _userViewModel.updateUser();
    }

    _chatRoom = chatRoom; // todo: remove
    addToMyChat(chatRoomID, chatRoom);
    notifyListeners();

    // 이동
    sl<NavigationService>()
        .pushNamed("/chat-room", arguments: {'chatRoomID': chatRoomID});
  }

  void clearChats() {
    _chats.clear();
  }

  void getChatroomImage(String chatRoomID) async {
    _chatRoom = await _chatRoomRepository.get(id: chatRoomID);
    _userViewModel.getMemberImagePath(memberIDs: _chatRoom?.members);
    notifyListeners();
  }

  Future<bool> addChat(String chatRoomID, String owner, String content) async {
    return await _chatRepository.addChat(
        id: chatRoomID,
        chat: Chat(
            createdAt: DateTime.now().toUtc(),
            owner: owner,
            content: content,
            reader: null));
  }

  void addChatRoom(
      {required String title,
      required DateTimeRange? travelDate,
      required String? country}) {
    _chatRoomRepository.add(
        chatRoom: ChatRoom(
            title: title,
            createdAt: DateTime.now().toUtc(),
            travelDateStart: travelDate!.start.toString(),
            travelDateEnd: travelDate.end.toString(),
            country: country!,
            owner: user.uid,
            members: [user.uid]));
  }
}
