import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/chat_room.dart';
import '../../domain/models/user.dart';

abstract class StoreRemoteDataSource {
  StoreRemoteDataSource();

  /// User
  Future<bool> addUser({required UserModel user});
  Future<UserModel?> getUser({String? id});
  Stream<UserModel?> getUserByStream();
  Future<bool> updateUser({required UserModel user});
  Future<bool> deleteUser();

  /// Chat Rooms
  Future<bool> addChatRoom({required ChatRoom chatRoom});
  Future<ChatRoom?> getChatRoom({required String id});
  Future<Map<String, ChatRoom>?> getAllChatRooms();
  Future<bool> updateChatRoom({required String id, required ChatRoom chatRoom});
  Future<void> updateLatestChatAt(
      {required String id, required Timestamp timestamp});
}
