import 'package:hyshare/app/pages/detail/controller.dart';
import 'package:get/get.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPageController>(() => DetailPageController());
  }
}
