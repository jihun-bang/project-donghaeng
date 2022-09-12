// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      title: json['title'] as String,
      createdAt: fromTimestamp(json['created_at'] as Timestamp),
      travelDateStart: json['travel_date_start'] as String,
      travelDateEnd: json['travel_date_end'] as String,
      country: json['country'] as String,
      owner: json['owner'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'title': instance.title,
      'created_at': toTimestamp(instance.createdAt),
      'travel_date_start': instance.travelDateStart,
      'travel_date_end': instance.travelDateEnd,
      'country': instance.country,
      'owner': instance.owner,
      'members': instance.members,
      'tags': instance.tags,
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