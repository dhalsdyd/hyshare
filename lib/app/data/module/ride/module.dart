import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/data/models/ride.dart';
import 'package:hyshare/app/data/models/user.dart';
import 'package:hyshare/app/data/service/auth/service.dart';

class RideModule extends GetxController {
  static RideModule get to => Get.find<RideModule>(); // add this line

  final AuthService authService = Get.find<AuthService>();

  Rx<List<Ride>> rides = Rx([]);
  Rx<Ride?> selectedRide = Rx(null);

  StreamSubscription? rideSubscription;
  StreamSubscription? selectRideSubscription;

  @override
  void onInit() async {
    super.onInit();

    rideSubscription = FirebaseFirestore.instance.collection('rides').where('status', isEqualTo: "hosting").snapshots().listen((event) {
      rides.value = event.docs.map((e) => Ride.fromJson(e.data())).toList();
    });

    final User user =
        await FirebaseFirestore.instance.collection('users').doc(authService.accessToken).get().then((value) => User.fromJson(value.data()!));

    if (user.rideId.isNotEmpty) {
      final data = await FirebaseFirestore.instance.collection('rides').doc(user.rideId).get();
      Ride ride = Ride.fromJson(data.data()!);
      selectedRide.value = ride;
      selectRide();
    }
  }

  Future<void> selectRide() async {
    log('selectRide');
    rideSubscription?.cancel();
    selectRideSubscription = FirebaseFirestore.instance.collection('rides').doc(selectedRide.value!.rideId).snapshots().listen((event) {
      selectedRide.value = Ride.fromJson(event.data()!);
    });
  }

  Future<void> unselectRide() async {
    selectRideSubscription?.cancel();
    selectedRide.value = null;
    rideSubscription = FirebaseFirestore.instance.collection('rides').where('status', isEqualTo: "hosting").snapshots().listen((event) {
      rides.value = event.docs.map((e) => Ride.fromJson(e.data())).toList();
    });
  }
}
