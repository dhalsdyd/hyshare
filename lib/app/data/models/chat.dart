// ignore_for_file: depend_on_referenced_packages

import 'package:hyshare/app/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Message {
  String messageId;
  String senderId;
  String message;
  DateTime timestamp;
  Message({
    required this.messageId,
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Chat {
  String chatId;
  String rideId;
  List<UserInfo> users;
  List<Message> messages;
  Chat({
    required this.chatId,
    required this.rideId,
    required this.users,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
