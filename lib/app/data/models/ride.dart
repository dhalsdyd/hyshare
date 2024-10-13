// ignore_for_file: depend_on_referenced_packages

import 'package:hyshare/app/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ride.g.dart';

// g.dart file generator : flutter pub run build_runner build

enum RideStatus {
  @JsonValue('hosting')
  hosting,
  @JsonValue('approved')
  approved,
  @JsonValue('default')
  defaultStatus,
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@JsonSerializable()
class Ride {
  String rideId;
  String hostUserId;
  String departue;
  String destination;
  int currentPassanger;
  int maxPassanger;
  int estimatedCostPerPassanger;
  String paymentMethod;
  RideStatus status;
  DateTime timestamp;
  DateTime departureTime;
  List<UserInfo> passangers;

  Ride({
    required this.rideId,
    required this.hostUserId,
    required this.departue,
    required this.destination,
    required this.currentPassanger,
    required this.maxPassanger,
    required this.estimatedCostPerPassanger,
    required this.paymentMethod,
    required this.status,
    required this.timestamp,
    required this.departureTime,
    required this.passangers,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
  Map<String, dynamic> toJson() => _$RideToJson(this);
}
