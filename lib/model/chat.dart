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

  @override
  String toString() {
    return 'Chatroom{title: $title, createdAt: $createdAt, travelDate: $travelDate, owner: $owner, members: $members, tags: $tags, chats: $chats}';
  }

  List<Chat>? chats;

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
