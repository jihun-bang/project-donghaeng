import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  String title;
  int members;
  int maxMember;
  List<String> tags;

  Chat(
      {required this.title,
      required this.members,
      required this.maxMember,
      required this.tags});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
