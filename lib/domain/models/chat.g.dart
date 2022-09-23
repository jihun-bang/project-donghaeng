// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      createdAt: DateTime.parse(json['createdAt'] as String),
      owner: json['owner'] as String,
      content: json['content'] as String,
      reader:
          (json['reader'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'owner': instance.owner,
      'content': instance.content,
      'reader': instance.reader,
    };
