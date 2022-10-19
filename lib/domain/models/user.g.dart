// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      backgroundImagePath: json['background_image_path'] as String? ?? '',
      imagePath: json['image_path'] as String? ?? '',
      description: json['description'] as String? ?? '',
      instagram: json['instagram'] as String? ?? '',
      chatRooms: (json['chat_rooms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'background_image_path': instance.backgroundImagePath,
      'image_path': instance.imagePath,
      'description': instance.description,
      'instagram': instance.instagram,
      'chat_rooms': instance.chatRooms,
    };
