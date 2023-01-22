import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  String phoneNumber;
  bool verified;
  String name;
  @JsonKey(name: 'background_image_path')
  String backgroundImagePath;
  @JsonKey(name: 'image_path')
  String imagePath;
  String description;
  String instagram;
  @JsonKey(name: 'chat_rooms')
  List<String>? chatRooms;
  // todo: chatRooms를 null을 허락하고 싶지 않은데, 아래 User()에서 초기화 하기도 애매하고,
  // 입장한 채팅방이 하나도 없다고 생각했을때, fire store에 기본값으로 "" 이게 하나 저장되서 깔끔하지가 않아서 고민

  UserModel(
      {required this.id,
      this.phoneNumber = '',
      this.verified = false,
      this.name = '',
      this.backgroundImagePath = '',
      this.imagePath = '',
      this.description = '',
      this.instagram = '',
      this.chatRooms});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  bool addChatRoomID(String chatRoomID) {
    chatRooms ??= <String>[];

    if (!chatRooms!.contains(chatRoomID)) {
      chatRooms!.add(chatRoomID);
      return true;
    }

    return false;
  }
}
