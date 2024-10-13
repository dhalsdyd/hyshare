import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/data/models/chat.dart';
import 'package:hyshare/app/data/module/ride/module.dart';

class ChatModule extends GetxController {
  static ChatModule get to => Get.find<ChatModule>(); // add this line

  RideModule rideModule = Get.find<RideModule>();
  Rx<List<Message>> chats = Rx([]);
  Rx<Chat?> selectedChat = Rx(null);

  @override
  void onInit() async {
    super.onInit();

    rideModule.selectedRide.listen((event) {
      if (event != null) {
        FirebaseFirestore.instance.collection('chats').doc(event.rideId).snapshots().listen((event) {
          selectedChat.value = Chat.fromJson(event.data()!);
        });
        FirebaseFirestore.instance.collection('chats').doc(event.rideId).collection("messages").snapshots().listen((event) {
          chats.value = event.docs.map((e) => Message.fromJson(e.data())).toList();
          chats.value.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        });
      }
    });
  }
}
