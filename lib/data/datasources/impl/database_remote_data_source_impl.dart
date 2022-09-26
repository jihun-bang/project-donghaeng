import 'package:donghaeng/domain/models/chat.dart';
import 'package:firebase_database/firebase_database.dart';

import '../database_remote_data_source.dart';

class DatabaseRemoteDataSourceImpl implements DatabaseRemoteDataSource {
  final chatRoomRef = FirebaseDatabase.instance.ref("chatrooms");

  @override
  Future<bool> addChat({required String chatroomID, required Chat chat}) async {
    try {
      await chatRoomRef.child('$chatroomID/chats').push().set(chat.toJson());
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<DatabaseEvent> getChatByStream({required String chatroomID}) {
    return chatRoomRef.child('$chatroomID/chats').limitToLast(50).onChildAdded;
  }
}
