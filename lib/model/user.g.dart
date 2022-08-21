// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      imagePath: json['image_path'] as String? ?? '',
      description: json['description'] as String? ?? '',
      instagram: json['instagram'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_path': instance.imagePath,
      'description': instance.description,
      'instagram': instance.instagram,
    };
