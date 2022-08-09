// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      title: json['title'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'title': instance.title,
      'start': instance.start,
      'end': instance.end,
      'members': instance.members,
      'tags': instance.tags,
    };
