import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chatroom {
  String title;
  DateTime createdAt;
  TravelDate travelDate;
  String owner;
  List<String> members;
  List<String>? tags;
  List<Chat>? chats;

  @override
  String toString() {
    return 'Chatroom{title: $title, createdAt: $createdAt, travelDate: $travelDate, owner: $owner, members: $members, tags: $tags, chats: $chats}';
  }

  Chatroom(
      {required this.title,
      required this.createdAt,
      required this.travelDate,
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

    // todo: 아래부분 때문에 id를 추가할지 고민
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

// todo: JsonSerializable 없어도 될꺼같은데, 좀 더 고민해봄
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
