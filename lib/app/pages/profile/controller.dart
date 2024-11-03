import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hyshare/app/data/models/user.dart';
import 'package:hyshare/app/data/service/auth/service.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:hyshare/app/widgets/snackbar.dart';

class ProfilePageController extends GetxController with StateMixin {
  static ProfilePageController get to => Get.find<ProfilePageController>(); // add this line

  AuthService authService = Get.find<AuthService>();

  Rx<User?> user = Rx<User?>(null);
  Rx<bool> allowNotification = Rx<bool>(true);

  final TextEditingController accountController = TextEditingController();

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(Routes.login);
  }

  Future<void> updatePaymentInfo() async {
    if (!RegExp(r'(?:국민|신한|우리|하나|농협|기업|SC제일|씨티|카카오|토스|수협|광주|전북|경남|부산|제주|새마을금고|우체국|산업|저축)\s*([0-9]{3,6}\-[0-9]{2,6}\-[0-9]{1,6})')
        .hasMatch(accountController.text)) {
      FGBPErrorSnackBar().open('계좌번호의 형식를 확인해주세요.');
      return;
    }

    change(null, status: RxStatus.loading());
    await FirebaseFirestore.instance.collection('users').doc(authService.accessToken).update({
      'paymentInfo': accountController.text,
    });
    change(null, status: RxStatus.success());
  }

  Future<void> updateNotification() async {
    if (allowNotification.value) {
      await authService.getFcmToken();
    } else {
      await authService.removeFcmToken();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    final data = await FirebaseFirestore.instance.collection('users').doc(authService.accessToken).get();
    user.value = User.fromJson(data.data()!);
    allowNotification.value = authService.fcmToken != null && authService.fcmToken!.isNotEmpty;
    change(null, status: RxStatus.success());
  }
}
