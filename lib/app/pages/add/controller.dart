import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/data/models/chat.dart';
import 'package:hyshare/app/data/models/ride.dart';
import 'package:hyshare/app/data/models/user.dart' as app;
import 'package:hyshare/app/data/module/ride/module.dart';
import 'package:hyshare/app/data/service/auth/service.dart';
import 'package:hyshare/app/widgets/snackbar.dart';

class AddPageController extends GetxController with StateMixin {
  static AddPageController get to => Get.find<AddPageController>(); // add this line

  final AuthService authService = Get.find<AuthService>();
  final RideModule rideModule = Get.find<RideModule>();

  List<String> places = [
    'ERICA,정문',
    'ERICA,후문',
    'ERICA,택시 정류장',
    'ERICA,창의인재원',
    '안산시 상록구,한대앞역',
    '안산시 상록구,중앙역',
    '안산시 상록구,상록수역',
  ];

  Rx<String> departure = ','.obs;
  Rx<String> destination = ','.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<int> month = DateTime.now().month.obs;
  Rx<int> day = DateTime.now().day.obs;
  Rx<int> hour = DateTime.now().hour.obs;
  Rx<int> minute = DateTime.now().minute.obs;

  Rx<int> maxParticipants = 4.obs;
  Rx<int> cost = 10000.obs;
  TextEditingController costController = TextEditingController();

  String get formattedDate =>
      '${selectedDate.value.year}년 ${selectedDate.value.month}월 ${selectedDate.value.day}일 ${selectedDate.value.hour.toString().padLeft(2, "0")}:${selectedDate.value.minute.toString().padLeft(2, "0")}';
  String get commaCost => (cost.value).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

  void setDeparture(String value) {
    departure.value = value;
  }

  void setDestination(String value) {
    destination.value = value;
  }

  void setDate() {
    selectedDate.value = DateTime(selectedDate.value.year, month.value, day.value, hour.value, minute.value);
  }

  bool get isValidate => departure.value.length > 1 && destination.value.length > 1;

  Future<void> shareRide() async {
    if (!isValidate) {
      return;
    }

    if (selectedDate.value.isBefore(DateTime.now())) {
      FGBPSnackBar.open('현재 시간 이후로 설정해주세요.');
      return;
    }

    String uid = DateTime.now().millisecondsSinceEpoch.toString();

    app.UserInfo user = app.UserInfo(
      userId: authService.accessToken!,
      name: authService.user.value!.nickname,
      photoUrl: authService.user.value!.photoUrl,
      fcmToken: authService.fcmToken ?? "",
    );

    Ride ride = Ride(
      rideId: uid,
      hostUserId: authService.accessToken!,
      departue: departure.value,
      destination: destination.value,
      currentPassanger: 1,
      maxPassanger: maxParticipants.value,
      estimatedCostPerPassanger: cost.value,
      departureTime: selectedDate.value,
      paymentMethod: "계좌 이체",
      status: RideStatus.hosting,
      timestamp: DateTime.now(),
      passangers: [],
    );

    Chat chat = Chat(
      chatId: uid,
      rideId: uid,
      users: [],
      messages: [],
    );

    change(null, status: RxStatus.loading());
    await FirebaseFirestore.instance.collection('rides').doc(ride.rideId).set(ride.toJson());
    await FirebaseFirestore.instance.collection('rides').doc(ride.rideId).update({
      'passangers': FieldValue.arrayUnion([user.toJson()])
    });

    await FirebaseFirestore.instance.collection('chats').doc(chat.chatId).set(chat.toJson());
    await FirebaseFirestore.instance.collection('chats').doc(chat.chatId).update({
      'users': FieldValue.arrayUnion([user.toJson()])
    });

    await FirebaseFirestore.instance.collection('users').doc(authService.accessToken).update({
      'rideId': ride.rideId,
      "status": RideStatus.hosting.name,
    });

    rideModule.selectedRide.value = ride;
    rideModule.selectRide();
    change(null, status: RxStatus.success());

    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
    costController.text = cost.value.toString();
    costController.addListener(() {
      if (costController.text.isEmpty) {
        cost.value = 0;
      } else {
        cost.value = int.parse(costController.text);
      }
    });
  }
}
