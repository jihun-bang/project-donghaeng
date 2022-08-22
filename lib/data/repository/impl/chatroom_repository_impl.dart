import 'package:donghaeng/data/repository/chatroom_repository.dart';
import 'package:donghaeng/model/chat.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatroomRepositoryImpl implements ChatroomRepository {
  final chatroomRef = FirebaseDatabase.instance.ref("chatrooms");

  ChatroomRepositoryImpl();

  @override
  Future<Chatroom?> getChatroom({required String chatroomID}) async {
    final snapshot = await chatroomRef.child(chatroomID).get();
    if (snapshot.exists) {
      return Chatroom.fromRealtimeDB(snapshot.value as Map);
    } else {
      // todo: 에러처리
      throw 'No data available.';
    }
  }

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
  Stream<DatabaseEvent> getChats({required String chatroomID}) {
    return chatroomRef.child('$chatroomID/chats').onChildAdded;
  }
}
