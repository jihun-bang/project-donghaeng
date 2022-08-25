import 'package:donghaeng/model/chat.dart';

abstract class ChatRoomRepository {
  Future<Map<String, ChatRoom>?> getAllChatRooms();
}
