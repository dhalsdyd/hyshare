// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      requestId: json['requestId'] as String,
      rideId: json['rideId'] as String,
      requestUserId: json['requestUserId'] as String,
      message: json['message'] as String,
      status: $enumDecode(_$RequestStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'requestId': instance.requestId,
      'rideId': instance.rideId,
      'requestUserId': instance.requestUserId,
      'message': instance.message,
      'status': _$RequestStatusEnumMap[instance.status]!,
    };

const _$RequestStatusEnumMap = {
  RequestStatus.pending: 'pending',
  RequestStatus.approved: 'approved',
  RequestStatus.defaultStatus: 'default',
  RequestStatus.cancelled: 'cancelled',
};
