import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  String title;
  DateTime createdAt;
  TravelDate travelDate;
  String owner;
  List<String> members;
  List<String> tags; // todo: 무슨 기능인지 모르겠어영
  List<ChatContent>? chatContents;

  Chat(
      {required this.title,
      required this.createdAt,
      required this.travelDate,
      required this.owner,
      required this.members,
      required this.tags,
      required this.chatContents});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
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
class ChatContent {
  DateTime createdAt;
  String owner;
  String content;
  List<String>? reader; // todo: 읽은 사람. 미확정

  ChatContent(
      {required this.createdAt,
      required this.owner,
      required this.content,
      required this.reader});

  factory ChatContent.fromJson(Map<String, dynamic> json) =>
      _$ChatContentFromJson(json);

  Map<String, dynamic> toJson() => _$ChatContentToJson(this);
}
