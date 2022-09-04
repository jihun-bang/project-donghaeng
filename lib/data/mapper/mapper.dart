import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/user.dart';

extension SnapshotMapper on DocumentSnapshot<Map<String, dynamic>> {
  User toUser() {
    return User?.fromJson(data()!);
  }

  ChatRoom toChatRoom() {
    return ChatRoom?.fromJson(data()!);
  }
}
