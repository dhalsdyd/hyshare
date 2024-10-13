import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/data/models/chat.dart';
import 'package:hyshare/app/data/models/ride.dart';
import 'package:hyshare/app/data/models/user.dart';
import 'package:hyshare/app/data/module/ride/module.dart';
import 'package:hyshare/app/data/service/auth/service.dart';
import 'package:hyshare/app/pages/home/controller.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:hyshare/app/widgets/snackbar.dart';

class DetailPageController extends GetxController with StateMixin {
  static DetailPageController get to => Get.find<DetailPageController>(); // add this line

  late Ride ride;

  AuthService authService = Get.find<AuthService>();
  RideModule rideModule = Get.find<RideModule>();

  bool get isOwner => authService.user.value!.status == UserStatus.hosting;
  bool get isParticipant => authService.user.value!.status == UserStatus.pending;

  @override
  void onInit() {
    super.onInit();
    ride = Get.arguments as Ride;
  }

  Future<void> selectRide() async {
    await FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore.instance.collection('rides').doc(ride.rideId));
        int currentPassanger = snapshot.get('currentPassanger');
        if (currentPassanger < snapshot.get('maxPassanger')) {
          transaction.update(FirebaseFirestore.instance.collection('rides').doc(ride.rideId), {
            'currentPassanger': FieldValue.increment(1),
          });
        } else {
          FGBPErrorSnackBar().open("정원이 초과되었습니다.");
          return;
        }
      },
    );

    rideModule.selectedRide.value = ride;
    rideModule.selectRide();

    UserInfo user = UserInfo(
      userId: authService.accessToken!,
      name: authService.user.value!.nickname,
      photoUrl: authService.user.value!.photoUrl,
      fcmToken: authService.fcmToken ?? "",
    );

    change(null, status: RxStatus.loading());
    await FirebaseFirestore.instance.collection("users").doc(authService.accessToken).update({
      "rideId": ride.rideId,
      "status": "pending",
    });

    FirebaseFirestore.instance.collection('chats').doc(ride.rideId).collection('messages').add({
      'messageId': DateTime.now().millisecondsSinceEpoch.toString(),
      'message': '${authService.user.value!.nickname}님이 입장하셨습니다.',
      'senderId': "system",
      'timestamp': DateTime.now().toIso8601String(),
    });

    FirebaseFirestore.instance.collection('rides').doc(ride.rideId).update({
      'passangers': FieldValue.arrayUnion([user.toJson()])
    });

    FirebaseFirestore.instance.collection('chats').doc(ride.rideId).update({
      'users': FieldValue.arrayUnion([user.toJson()])
    });
    change(null, status: RxStatus.success());

    Get.back();
  }

  Future<void> cancelRide() async {
    rideModule.selectedRide.value = null;
    rideModule.unselectRide();
    log("${rideModule.selectedRide.value != null}");
    log("${HomePageController.to.isChat}");

    change(null, status: RxStatus.loading());

    log("${authService.user.value!.status} ${ride.status}");

    if (authService.user.value!.status == UserStatus.hosting && ride.status != RideStatus.completed) {
      await FirebaseFirestore.instance.collection('rides').doc(ride.rideId).update({
        'status': "cancelled",
      });

      await FirebaseFirestore.instance.collection("users").doc(authService.accessToken).update({
        "rideId": "",
        "status": "default",
      });
    } else if (ride.status != RideStatus.completed) {
      await FirebaseFirestore.instance.collection("users").doc(authService.accessToken).update({
        "rideId": "",
        "status": "default",
      });

      UserInfo user = UserInfo(
        userId: authService.accessToken!,
        name: authService.user.value!.nickname,
        photoUrl: authService.user.value!.photoUrl,
        fcmToken: authService.fcmToken ?? "",
      );

      FirebaseFirestore.instance.collection('rides').doc(ride.rideId).update({
        'currentPassanger': FieldValue.increment(-1),
        'passangers': FieldValue.arrayRemove([user.toJson()])
      });

      FirebaseFirestore.instance.collection('chats').doc(ride.rideId).update({
        'users': FieldValue.arrayRemove([user.toJson()])
      });
    }

    FirebaseFirestore.instance.collection('chats').doc(ride.rideId).collection('messages').add({
      'messageId': DateTime.now().millisecondsSinceEpoch.toString(),
      'message': '${authService.user.value!.nickname}님이 퇴장하셨습니다.',
      'senderId': "system",
      'timestamp': DateTime.now().toIso8601String(),
    });

    change(null, status: RxStatus.success());

    Get.offAllNamed(Routes.home);
  }

  Future<void> letsgo() async {
    await FirebaseFirestore.instance.collection('users').doc(authService.accessToken).update({
      'status': "pending",
    });

    await FirebaseFirestore.instance.collection('rides').doc(ride.rideId).update({
      'status': "completed",
    });

    Message chat = Message(
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        message: authService.user.value!.paymentInfo,
        senderId: authService.accessToken!,
        timestamp: DateTime.now());
    await FirebaseFirestore.instance.collection('chats').doc(ride.rideId).collection('messages').add(chat.toJson());
    Get.back();
  }
}
