import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donghaeng/data/mapper/mapper.dart';
import 'package:donghaeng/domain/models/chat.dart';
import 'package:donghaeng/domain/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../utils/toast.dart';
import '../store_remote_data_source.dart';

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  final auth = firebase_auth.FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final chatRoomCollection =
      FirebaseFirestore.instance.collection('chat_rooms');

  /// User
  @override
  Future<bool> addUser({required User user}) async {
    try {
      await usersCollection.doc(auth.currentUser?.uid).set(user.toJson());
      return true;
    } catch (e) {
      showToast(message: '회원가입에 실패했습니다.. 😭');
      throw Exception(e);
    }
  }

  @override
  Future<User> getUser({String? id}) async {
    final snapshot =
        await usersCollection.doc(id ?? auth.currentUser?.uid).get();
    if (snapshot.exists) {
      return snapshot.toUser();
    } else {
      throw Exception(
          '[StoreRemoteDataSource] ${id ?? auth.currentUser?.uid} 존재하지 않음');
    }
  }

  @override
  Stream<User> getUserByStream() {
    return usersCollection
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((event) => event.toUser());
  }

  @override
  Future<bool> updateUser({required User user}) async {
    try {
      await usersCollection.doc(auth.currentUser?.uid).update(user.toJson());
      return true;
    } catch (e) {
      print(e);
      showToast(message: '업데이트를 실패했습니다.. 😭');
      return false;
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      await auth.currentUser?.delete();
      await usersCollection.doc(auth.currentUser?.uid).delete();
      return true;
    } catch (e) {
      print(e);
      showToast(message: '계정 삭제를 실패했습니다.. 😭');
      return false;
    }
  }

  /// Chat Room
  @override
  Future<bool> addChatRoom({required ChatRoom chatRoom}) async {
    try {
      await chatRoomCollection.add(chatRoom.toJson());
      return true;
    } catch (e) {
      showToast(message: '회원가입에 실패했습니다.. 😭');
      throw Exception(e);
    }
  }

  @override
  Future<ChatRoom> getChatRoom({required String id}) async {
    try {
      final snapShot = await chatRoomCollection.doc(id).get();
      return snapShot.toChatRoom();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<Map<String, ChatRoom>?> getAllChatRooms() async {
    try {
      Map<String, ChatRoom> result = {};
      await chatRoomCollection.get().then((value) {
        for (var doc in value.docs) {
          result[doc.id] = ChatRoom.fromJson(doc.data());
        }
      });
      return result;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateChatRoom(
      {required String id, required ChatRoom chatRoom}) async {
    try {
      await chatRoomCollection.doc(id).update(chatRoom.toJson());
      return true;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
