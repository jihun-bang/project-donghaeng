import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
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

  @override
  String toString() {
    return 'User{id: $id, name: $name, imagePath: $imagePath, description: $description, instagram: $instagram}';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
