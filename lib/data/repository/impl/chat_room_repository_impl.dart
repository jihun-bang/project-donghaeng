import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donghaeng/data/repository/chat_room_repository.dart';
import 'package:donghaeng/model/chat.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('chat_rooms');

  ChatRoomRepositoryImpl();

  @override
  Future<Map<String, ChatRoom>?> getAllChatRooms() async {
    try {
      Map<String, ChatRoom> result = {};

      await chatRooms.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          result[doc.id] =
              ChatRoom.fromJson(doc.data() as Map<String, dynamic>);
        });
      });

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
