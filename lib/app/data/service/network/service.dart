// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

class ConnectionService extends GetxService {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  final Rx<ConnectivityStatus> connectionType = Rx(ConnectivityStatus.Offline);
  late StreamSubscription _connectionSubscription;
  final Connectivity _connectivity = Connectivity();

  Future<void> listenToConnection() async {
    _connectionSubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.wifi)) {
      connectionType.value = ConnectivityStatus.WiFi;
    } else if (result.contains(ConnectivityResult.mobile)) {
      connectionType.value = ConnectivityStatus.Cellular;
    } else {
      connectionType.value = ConnectivityStatus.Offline;
    }
  }

  Future<ConnectionService> init() async {
    await listenToConnection();
    return this;
  }

  @override
  void onClose() {
    _connectionSubscription.cancel();
    super.onClose();
  }
}
