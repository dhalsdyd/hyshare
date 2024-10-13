// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/data/models/ride.dart';

extension RideStatusExtension on RideStatus {
  String get name {
    switch (this) {
      case RideStatus.hosting:
        return '모집중';
      case RideStatus.approved:
        return '승인됨';
      case RideStatus.defaultStatus:
        return '기본';
      case RideStatus.pending:
        return '대기중';
      case RideStatus.completed:
        return '완료됨';
      case RideStatus.cancelled:
        return '취소됨';
    }
  }

  Color get color {
    switch (this) {
      case RideStatus.hosting:
        return FGBPColors.mainColor;
      case RideStatus.approved:
        return Colors.green;
      case RideStatus.defaultStatus:
        return Colors.grey;
      case RideStatus.pending:
        return Colors.orange;
      case RideStatus.completed:
        return Colors.green;
      case RideStatus.cancelled:
        return Colors.red;
    }
  }
}

extension commaCostExtension on int {
  String get commaCost => (this).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

extension formattedDateExtension on DateTime {
  String get formattedDateYMDHM {
    return '$year.${month.toString().padLeft(2, "0")}.${day.toString().padLeft(2, "0")} ${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}';
  }

  String get formattedDateMDHM {
    return '$month월 $day일 ${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}';
  }
}
