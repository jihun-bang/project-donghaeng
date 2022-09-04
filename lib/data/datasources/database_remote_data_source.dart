import 'package:firebase_database/firebase_database.dart';

import '../../domain/models/chat.dart';

abstract class DatabaseRemoteDataSource {
  DatabaseRemoteDataSource();

  /// Chat
  Future<bool> addChat({required String chatroomID, required Chat chat});
  Stream<DatabaseEvent> getChatByStream({required String chatroomID});
}
