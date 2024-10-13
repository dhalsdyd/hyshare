// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      userId: json['userId'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      fcmToken: json['fcmToken'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'fcmToken': instance.fcmToken,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String,
      rideId: json['rideId'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      photoUrl: json['photoUrl'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      paymentInfo: json['paymentInfo'] as String,
      warningCount: (json['warningCount'] as num).toInt(),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      fcmTokens:
          (json['fcmTokens'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'rideId': instance.rideId,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'nickname': instance.nickname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'paymentInfo': instance.paymentInfo,
      'warningCount': instance.warningCount,
      'status': _$UserStatusEnumMap[instance.status]!,
      'fcmTokens': instance.fcmTokens,
    };

const _$UserStatusEnumMap = {
  UserStatus.hosting: 'hosting',
  UserStatus.approved: 'approved',
  UserStatus.defaultStatus: 'default',
  UserStatus.pending: 'pending',
};
