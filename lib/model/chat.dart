import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  String title;
  String start;
  String end;
  List<String> members;
  List<String> tags;

  Chat(
      {required this.title,
      required this.start,
      required this.end,
      required this.members,
      required this.tags});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
