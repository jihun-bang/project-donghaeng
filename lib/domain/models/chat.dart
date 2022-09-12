import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/datetime.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatRoom {
  final String title;
  @JsonKey(name: "created_at", fromJson: fromTimestamp, toJson: toTimestamp)
  final DateTime createdAt;
  @JsonKey(name: "travel_date_start")
  final String travelDateStart;
  @JsonKey(name: "travel_date_end")
  final String travelDateEnd;
  final String country;
  final String owner;
  final List<String> members;
  final List<String>? tags;

  ChatRoom(
      {required this.title,
      required this.createdAt,
      required this.travelDateStart,
      required this.travelDateEnd,
      required this.country,
      required this.owner,
      required this.members,
      this.tags});

  ChatRoom copyWith(
      {String? title,
      DateTime? createdAt,
      String? travelDateStart,
      String? travelDateEnd,
      String? country,
      String? owner,
      List<String>? members,
      List<String>? tags}) {
    return ChatRoom(
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        travelDateEnd: travelDateStart ?? this.travelDateStart,
        travelDateStart: travelDateStart ?? this.travelDateStart,
        country: country ?? this.country,
        owner: owner ?? this.owner,
        members: members ?? this.members,
        tags: tags ?? this.tags);
  }

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
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
      this.reader});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
