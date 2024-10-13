import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/data/service/auth/service.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:hyshare/app/widgets/snackbar.dart';

class OnboardingPageController extends GetxController with StateMixin {
  static OnboardingPageController get to => Get.find<OnboardingPageController>(); // add this line

  AuthService authService = Get.find<AuthService>();

  Rx<int> index = 0.obs;

  void next() {
    index.value++;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController accountController = TextEditingController();

  Rx<String> name = ''.obs;
  Rx<String> account = ''.obs;

  bool get isValidate => name.value.isNotEmpty && account.value.isNotEmpty;

  Future<bool> isUserNameDuplicate(String userName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Firestore에서 해당 이름을 가진 사용자 쿼리
    QuerySnapshot querySnapshot = await firestore.collection('users').where('name', isEqualTo: userName).get();

    // 쿼리 결과가 비어 있으면 중복이 아님 (false 리턴)
    if (querySnapshot.docs.isEmpty) {
      return false;
    } else {
      return true; // 중복된 이름이 있으면 true 리턴
    }
  }

  Future<void> submit() async {
    if (!isValidate) {
      log('invalid');
      return;
    }

    if (!RegExp(r'(?:국민|신한|우리|하나|농협|기업|SC제일|씨티|카카오|토스|수협|광주|전북|경남|부산|제주|새마을금고|우체국|산업|저축)\s*([0-9]{3,6}\-[0-9]{2,6}\-[0-9]{1,6})')
        .hasMatch(account.value)) {
      FGBPErrorSnackBar().open('계좌번호의 형식를 확인해주세요.');
      return;
    }

    if (await isUserNameDuplicate(name.value)) {
      FGBPErrorSnackBar().open('이미 사용 중인 이름입니다.');
      return;
    }
    //(?:국민|신한|우리|하나|농협|NH농협|IBK기업|SC제일|한국씨티|카카오|토스|수협|광주|전북|경남|부산|제주|새마을금고|우체국|산업|저축|케이뱅크|대구|부흥|중소기업|SBI저축|페퍼저축|OK저축|웰컴저축|한국산업|주택도시|삼성증권|한국투자증권|미래에셋|대신증권|유안타증권|키움증권|신영증권)\s*([0-9]{3,6}\-[0-9]{2,6}\-[0-9]{1,6})

    change(null, status: RxStatus.loading());
    await authService.registerUser(name.value, account.value);
    change(null, status: RxStatus.success());

    Get.offAllNamed(Routes.home);
  }

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
    nameController.addListener(() {
      name.value = nameController.text;
    });
    accountController.addListener(() {
      account.value = accountController.text;
    });
  }
}
