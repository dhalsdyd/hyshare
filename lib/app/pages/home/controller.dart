import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/data/models/chat.dart';
import 'package:hyshare/app/data/models/ride.dart';
import 'package:hyshare/app/data/module/chat/module.dart';
import 'package:hyshare/app/data/module/ride/module.dart';
import 'package:hyshare/app/data/service/auth/service.dart';
import 'package:hyshare/app/pages/home/widget/recommand.dart';

class HomePageController extends GetxController with StateMixin {
  static HomePageController get to => Get.find<HomePageController>(); // add this line

  final AuthService authService = Get.find<AuthService>();
  final RideModule rideModule = Get.find<RideModule>();
  final ChatModule chatModule = Get.find<ChatModule>();

  List<Ride> get rides => rideModule.rides.value;
  List<Message> get chats => chatModule.chats.value;

  Ride? get selectedRide => rideModule.selectedRide.value;

  final TextEditingController chatController = TextEditingController();

  bool get isChat => rideModule.selectedRide.value != null;
  bool isMe(String senderId) => senderId == authService.accessToken;

  bool isAccount(String account) {
    if (!RegExp(r'(?:국민|신한|우리|하나|농협|기업|SC제일|씨티|카카오|토스|수협|광주|전북|경남|부산|제주|새마을금고|우체국|산업|저축)\s*([0-9]{3,6}\-[0-9]{2,6}\-[0-9]{1,6})').hasMatch(account)) {
      return false;
    }
    return true;
  }

  Future<void> sendMessage() async {
    if (chatController.text.isEmpty) {
      return;
    }
    Message chat = Message(
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        message: chatController.text,
        senderId: authService.accessToken!,
        timestamp: DateTime.now());

    chatController.clear();

    change(null, status: RxStatus.loading());

    await FirebaseFirestore.instance.collection('chats').doc(selectedRide!.rideId).collection('messages').add(chat.toJson());

    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.success());
  }
}
