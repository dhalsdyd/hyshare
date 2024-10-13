// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// g.dart file generator : flutter pub run build_runner build

enum UserStatus {
  @JsonValue('hosting')
  hosting,
  @JsonValue('approved')
  approved,
  @JsonValue('default')
  defaultStatus,
  @JsonValue('pending')
  pending,
}

@JsonSerializable()
class UserInfo {
  String userId;
  String name;
  String photoUrl;
  String fcmToken;

  UserInfo({
    required this.userId,
    required this.name,
    required this.photoUrl,
    required this.fcmToken,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class User {
  String userId;
  String rideId;
  String name;
  String photoUrl;
  String nickname;
  String email;
  String phoneNumber;
  String paymentInfo;
  int warningCount;
  UserStatus status;
  List<String> fcmTokens;

  User({
    required this.userId,
    required this.rideId,
    required this.name,
    required this.nickname,
    required this.photoUrl,
    required this.email,
    required this.phoneNumber,
    required this.paymentInfo,
    required this.warningCount,
    required this.status,
    required this.fcmTokens,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
