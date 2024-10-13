import 'package:hyshare/app/pages/setting/controller.dart';
import 'package:get/get.dart';

class SettingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingPageController>(() => SettingPageController());
  }
}
