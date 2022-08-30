import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donghaeng/data/repository/chat_room_repository.dart';
import 'package:donghaeng/model/chat.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final chatRoomsCol = FirebaseFirestore.instance.collection('chat_rooms');

  final chatRoomRef =
      FirebaseFirestore.instance.collection('chat_rooms').withConverter(
            fromFirestore: (snapshot, _) => ChatRoom.fromJson(snapshot.data()!),
            toFirestore: (chatRoom, _) => chatRoom.toJson(),
          );

  ChatRoomRepositoryImpl();

  @override
  void add({required ChatRoom chatRoom}) {
    chatRoomRef.add(chatRoom);
  }

  // todo: 에러처리 viewmodel에서 하기
  @override
  Future<Map<String, ChatRoom>?> getAllChatRooms() async {
    try {
      Map<String, ChatRoom> result = {};

      await chatRoomRef.get().then((value) {
        for (var doc in value.docs) {
          result[doc.id] = doc.data();
        }
      });

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<ChatRoom?> getChatRoom({required String chatRoomID}) async {
    final chatRoom = await chatRoomRef.doc(chatRoomID).get();
    return chatRoom.data();
  }

  @override
  void updateChatRoom(String chatRoomID, ChatRoom chatRoom) async {
    await chatRoomRef.doc(chatRoomID).update(chatRoom.toJson());
  }
}
