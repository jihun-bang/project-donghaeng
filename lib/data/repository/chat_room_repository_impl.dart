import '../../domain/models/chat.dart';
import '../../domain/repositories/chat_room_repository.dart';
import '../datasources/store_remote_data_source.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final StoreRemoteDataSource storeRemoteDataSource;

  ChatRoomRepositoryImpl({required this.storeRemoteDataSource});

  @override
  Future<bool?> add({required ChatRoom chatRoom}) async {
    try {
      return await storeRemoteDataSource.addChatRoom(chatRoom: chatRoom);
    } catch (e) {
      return null;
    }
  }

  // todo: 에러처리 viewmodel에서 하기
  @override
  Future<Map<String, ChatRoom>?> getAll() async {
    try {
      return await storeRemoteDataSource.getAllChatRooms();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ChatRoom?> get({required String id}) async {
    try {
      return await storeRemoteDataSource.getChatRoom(id: id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> update(String chatRoomID, ChatRoom chatRoom) async {
    try {
      return await storeRemoteDataSource.updateChatRoom(
          id: chatRoomID, chatRoom: chatRoom);
    } catch (e) {
      return null;
    }
  }
}
