// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      travelDate:
          TravelDate.fromJson(json['travelDate'] as Map<String, dynamic>),
      owner: json['owner'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      chatContents: (json['chatContents'] as List<dynamic>?)
          ?.map((e) => ChatContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'travelDate': instance.travelDate,
      'owner': instance.owner,
      'members': instance.members,
      'tags': instance.tags,
      'chatContents': instance.chatContents,
    };

TravelDate _$TravelDateFromJson(Map<String, dynamic> json) => TravelDate(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$TravelDateToJson(TravelDate instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

ChatContent _$ChatContentFromJson(Map<String, dynamic> json) => ChatContent(
      createdAt: DateTime.parse(json['createdAt'] as String),
      owner: json['owner'] as String,
      content: json['content'] as String,
      reader:
          (json['reader'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChatContentToJson(ChatContent instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'owner': instance.owner,
      'content': instance.content,
      'reader': instance.reader,
    };
