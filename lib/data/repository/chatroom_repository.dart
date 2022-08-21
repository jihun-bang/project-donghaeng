import 'package:donghaeng/model/chat.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class ChatroomRepository {
  Future<Chatroom?> getChatroom({required String chatroomID});
  Future<bool> addChat({required String chatroomID, required Chat chat});
  Stream<DatabaseEvent> getChats({required String chatroomID});
}
