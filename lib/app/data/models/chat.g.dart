// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      messageId: json['messageId'] as String,
      senderId: json['senderId'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      chatId: json['chatId'] as String,
      rideId: json['rideId'] as String,
      users: (json['users'] as List<dynamic>)
          .map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'rideId': instance.rideId,
      'users': instance.users,
      'messages': instance.messages,
    };
