import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/chat_room.dart';
import '../../domain/models/user.dart';

extension SnapshotMapper on DocumentSnapshot<Map<String, dynamic>> {
  UserModel toUser() {
    return UserModel?.fromJson(data()!);
  }

  ChatRoom toChatRoom() {
    return ChatRoom?.fromJson(data()!);
  }
}
