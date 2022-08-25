import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatRoom {
  String title;
  @JsonKey(name: "created_at", fromJson: dateTimeFromTimestamp)
  DateTime createdAt;
  @JsonKey(name: "travel_date_start")
  String travelDateStart;
  @JsonKey(name: "travel_date_end")
  String travelDateEnd;
  String? country;
  String owner;
  List<String> members;
  List<String>? tags;

  @override
  String toString() {
    return 'ChatRoom{title: $title, createdAt: $createdAt, travelDateStart: $travelDateStart, travelDateEnd: $travelDateEnd, country: $country, owner: $owner, members: $members, tags: $tags}';
  }

  ChatRoom(
      {required this.title,
      required this.createdAt,
      required this.travelDateStart,
      required this.travelDateEnd,
      this.country,
      required this.owner,
      required this.members,
      this.tags});

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}

DateTime dateTimeFromTimestamp(Timestamp timestamp) {
  return timestamp.toDate();
}

// todo: remove
@JsonSerializable()
class Chatroom {
  String title;
  DateTime createdAt;
  TravelDate travelDate;
  String? country;
  String owner;
  List<String> members;
  List<String>? tags;
  List<Chat>? chats;

  @override
  String toString() {
    return 'Chatroom{title: $title, createdAt: $createdAt, travelDate: $travelDate, country: $country, owner: $owner, members: $members, tags: $tags, chats: $chats}';
  }

  Chatroom(
      {required this.title,
      required this.createdAt,
      required this.travelDate,
      this.country,
      required this.owner,
      required this.members,
      this.tags,
      this.chats});

  factory Chatroom.fromJson(Map<String, dynamic> json) =>
      _$ChatroomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatroomToJson(this);

  factory Chatroom.fromRealtimeDB(Map<dynamic, dynamic> data) {
    Map<String, dynamic> json = <String, dynamic>{};
    Map<String, dynamic>.from(data).forEach((key, value) {
      json[key] = value;
    });

    // todo: 아래부분 때문에 id를 추가할지 고민 (구조가 chatroom/chats/{chat_id}/chat
    if (json.containsKey("chats")) {
      json['chats'] =
          Map<String, dynamic>.from(json["chats"] as Map).values.toList();
    } else {
      json['chats'] = null;
    }

    return Chatroom.fromJson(json);
  }

  int countMember() {
    return members.length;
  }
}

@JsonSerializable()
class TravelDate {
  String start;
  String end;

  TravelDate({required this.start, required this.end});

  factory TravelDate.fromJson(Map<String, dynamic> json) =>
      _$TravelDateFromJson(json);

  Map<String, dynamic> toJson() => _$TravelDateToJson(this);
}

@JsonSerializable()
class Chat {
  DateTime createdAt;
  String owner;
  String content;
  List<String>? reader; // todo: 읽은 사람. 미확정

  Chat(
      {required this.createdAt,
      required this.owner,
      required this.content,
      required this.reader});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
