import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/chat_room.dart';
import '../../domain/models/user.dart';

abstract class StoreRemoteDataSource {
  StoreRemoteDataSource();

  /// User
  Future<bool> addUser({required User user});
  Future<User?> getUser({String? id});
  Stream<User?> getUserByStream();
  Future<bool> updateUser({required User user});
  Future<bool> deleteUser();

  /// Chat Rooms
  Future<bool> addChatRoom({required ChatRoom chatRoom});
  Future<ChatRoom?> getChatRoom({required String id});
  Future<Map<String, ChatRoom>?> getAllChatRooms();
  Future<bool> updateChatRoom({required String id, required ChatRoom chatRoom});
  Future<void> updateLatestChatAt(
      {required String id, required Timestamp timestamp});
}
