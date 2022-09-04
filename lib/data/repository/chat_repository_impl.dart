import 'package:donghaeng/domain/repositories/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../domain/models/chat.dart';
import '../datasources/database_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final DatabaseRemoteDataSource databaseRemoteDataSource;

  ChatRepositoryImpl({required this.databaseRemoteDataSource});

  @override
  Future<bool> addChat({required String id, required Chat chat}) async {
    try {
      return databaseRemoteDataSource.addChat(chatroomID: id, chat: chat);
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Stream<DatabaseEvent> getChatStream({required String id}) {
    return databaseRemoteDataSource.getChatByStream(chatroomID: id);
  }
}
