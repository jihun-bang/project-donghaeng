import 'package:donghaeng/model/chat.dart';

abstract class ChatRoomRepository {
  Future<Map<String, ChatRoom>?> getAllChatRooms();
  Future<ChatRoom?> getChatRoom({required String chatRoomID});
  Future updateChatRoom(String chatRoomID, ChatRoom chatRoom);
}