import 'package:hyshare/app/pages/add/controller.dart';
import 'package:get/get.dart';

class AddPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPageController>(() => AddPageController());
  }
}
