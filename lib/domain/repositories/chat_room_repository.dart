import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_room.dart';

abstract class ChatRoomRepository {
  void add({required ChatRoom chatRoom});

  Future<ChatRoom?> get({required String id});

  Future<Map<String, ChatRoom>?> getAll();

  void update(String chatRoomID, ChatRoom chatRoom);

  Future<void> updateLatestChatAt(String id, Timestamp timestamp);
}
