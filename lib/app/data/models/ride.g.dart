// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ride _$RideFromJson(Map<String, dynamic> json) => Ride(
      rideId: json['rideId'] as String,
      hostUserId: json['hostUserId'] as String,
      departue: json['departue'] as String,
      destination: json['destination'] as String,
      currentPassanger: (json['currentPassanger'] as num).toInt(),
      maxPassanger: (json['maxPassanger'] as num).toInt(),
      estimatedCostPerPassanger:
          (json['estimatedCostPerPassanger'] as num).toInt(),
      paymentMethod: json['paymentMethod'] as String,
      status: $enumDecode(_$RideStatusEnumMap, json['status']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      departureTime: DateTime.parse(json['departureTime'] as String),
      passangers: (json['passangers'] as List<dynamic>)
          .map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RideToJson(Ride instance) => <String, dynamic>{
      'rideId': instance.rideId,
      'hostUserId': instance.hostUserId,
      'departue': instance.departue,
      'destination': instance.destination,
      'currentPassanger': instance.currentPassanger,
      'maxPassanger': instance.maxPassanger,
      'estimatedCostPerPassanger': instance.estimatedCostPerPassanger,
      'paymentMethod': instance.paymentMethod,
      'status': _$RideStatusEnumMap[instance.status]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'departureTime': instance.departureTime.toIso8601String(),
      'passangers': instance.passangers,
    };

const _$RideStatusEnumMap = {
  RideStatus.hosting: 'hosting',
  RideStatus.approved: 'approved',
  RideStatus.defaultStatus: 'default',
  RideStatus.pending: 'pending',
  RideStatus.completed: 'completed',
  RideStatus.cancelled: 'cancelled',
};
