import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donghaeng/data/repository/chat_room_repository.dart';
import 'package:donghaeng/model/chat.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final CollectionReference chatRoomsCol =
      FirebaseFirestore.instance.collection('chat_rooms');

  final chatRoomRef =
      FirebaseFirestore.instance.collection('chat_rooms').withConverter(
            fromFirestore: (snapshot, _) => ChatRoom.fromJson(snapshot.data()!),
            toFirestore: (chatRoom, _) => chatRoom.toJson(),
          );

  ChatRoomRepositoryImpl();

  // todo: 에러처리 viewmodel에서 하기
  @override
  Future<Map<String, ChatRoom>?> getAllChatRooms() async {
    try {
      Map<String, ChatRoom> result = {};

      await chatRoomsCol.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          result[doc.id] =
              ChatRoom.fromJson(doc.data() as Map<String, dynamic>);
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
  Future updateChatRoom(String chatRoomID, ChatRoom chatRoom) async {
    await chatRoomsCol.doc(chatRoomID).update(chatRoom.toJson());
  }
}
