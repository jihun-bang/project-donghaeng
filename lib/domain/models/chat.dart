import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

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
