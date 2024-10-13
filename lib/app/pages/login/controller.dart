import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/core/util/google_login.dart';
import 'package:hyshare/app/data/service/auth/service.dart';
import 'package:hyshare/app/routes/route.dart';

class LoginPageController extends GetxController with StateMixin {
  static LoginPageController get to => Get.find<LoginPageController>(); // add this line

  AuthService authService = Get.find<AuthService>();
  // final TextEditingController emailController = TextEditingController();
  // Rx<bool> isLogin = false.obs;
  // Rx<bool> verifyEmail = false.obs;
  Rx<UserCredential?> tempToken = Rx(null);

  // Future<void> primaryLogin() async {
  //   if (emailController.text.isEmpty) {
  //     FGBPSnackBar.open('이메일을 입력해주세요.');
  //     return;
  //   }
  //   if (!emailController.text.contains('hanyang.ac.kr')) {
  //     FGBPSnackBar.open('한양대학교 이메일로 로그인해주세요.');
  //     return;
  //   }

  //   try {
  //     tempToken.value = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: "password");
  //   } on FirebaseAuthException catch (error) {
  //     switch (error.code) {
  //       case "email-already-in-use":
  //         tempToken.value = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: "password");
  //         break;
  //       case "invalid-email":
  //         break;
  //       case "weak-password":
  //         break;
  //       case "operation-not-allowed":
  //         break;
  //       default:
  //     }
  //   }

  //   if (tempToken.value == null) {
  //     FGBPSnackBar.open('이메일을 확인해주세요.');
  //     return;
  //   }

  //   await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  //   FGBPSnackBar.open('이메일을 확인해주세요.');

  //   isLogin.value = true;
  // }

  Future<void> loginWithGoogle() async {
    if (kIsWeb) {
      await loginWithGoogleWeb();
    } else {
      await loginWithGoogleMobile();
    }
  }

  Future<void> loginWithGoogleMobile() async {
    tempToken.value = await GoogleSignHelper().authenticate();
    bool? check = await authService.checkOnboarding(tempToken.value);
    if (check == null) {
      change(null, status: RxStatus.error('로그인에 실패했습니다.'));
      return;
    }
    if (check) {
      await authService.login();
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.onboarding);
    }
  }

  Future<void> loginWithGoogleWeb() async {
    final GoogleAuthProvider provider = GoogleAuthProvider().setCustomParameters({'prompt': 'select_account'});
    UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(provider);

    // if (userCredential.user == null || userCredential.user!.email!.contains('hanyang.ac.kr') == false) {
    //   FGBPSnackBar.open("한양대학교 이메일로 로그인해주세요.");
    //   return;
    // }

    tempToken.value = userCredential;
    bool? check = await authService.checkOnboarding(tempToken.value);
    if (check == null) {
      change(null, status: RxStatus.error('로그인에 실패했습니다.'));
      return;
    }
    if (check) {
      await authService.login();
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.onboarding);
    }
  }
}
