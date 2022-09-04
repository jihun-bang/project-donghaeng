import 'package:firebase_database/firebase_database.dart';

import '../models/chat.dart';

abstract class ChatRepository {
  Future<bool> addChat({required String id, required Chat chat});

  Stream<DatabaseEvent> getChatStream({required String id});
}
