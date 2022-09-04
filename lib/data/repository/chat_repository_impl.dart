import 'package:donghaeng/domain/repositories/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../domain/models/chat.dart';

class ChatRepositoryImpl implements ChatRepository {
  final chatroomRef = FirebaseDatabase.instance.ref("chatrooms");

  ChatRepositoryImpl();

  @override
  Future<bool> addChat({required String chatroomID, required Chat chat}) async {
    try {
      await chatroomRef.child('$chatroomID/chats').push().set(chat.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Stream<DatabaseEvent> getChatStream({required String chatroomID}) {
    return chatroomRef.child('$chatroomID/chats').onChildAdded;
  }
}
