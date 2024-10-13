// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'request.g.dart';

// g.dart file generator : flutter pub run build_runner build

enum RequestStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('default')
  defaultStatus,
  @JsonValue('cancelled')
  cancelled,
}

@JsonSerializable()
class Request {
  String requestId;
  String rideId;
  String requestUserId;
  String message;
  RequestStatus status;

  Request({
    required this.requestId,
    required this.rideId,
    required this.requestUserId,
    required this.message,
    required this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);
  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
