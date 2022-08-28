import 'package:donghaeng/model/chat.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class ChatRepository {
  Future<bool> addChat({required String chatroomID, required Chat chat});

  Stream<DatabaseEvent> getChatStream({required String chatroomID});
}
