// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

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
      latestChatAt: fromTimestamp(json['latest_chat_at'] as Timestamp),
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
      'latest_chat_at': toTimestamp(instance.latestChatAt),
    };
