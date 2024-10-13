import 'package:hyshare/app/pages/profile/controller.dart';
import 'package:get/get.dart';

class ProfilePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(() => ProfilePageController());
  }
}
