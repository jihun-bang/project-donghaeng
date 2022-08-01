import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  @JsonKey(name: 'nick_name')
  String nickName;
  @JsonKey(name: 'image_path')
  String imagePath;

  User(this.id, this.nickName, this.imagePath);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
