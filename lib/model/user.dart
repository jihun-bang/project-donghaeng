import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'image_path')
  String imagePath;
  String description;
  String instagram;

  User(
      {required this.id,
      this.name = '',
      this.imagePath = '',
      this.description = '',
      this.instagram = ''});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
