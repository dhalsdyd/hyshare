import 'package:get/get.dart';
import 'package:hyshare/app/data/module/chat/module.dart';
import 'package:hyshare/app/data/module/ride/module.dart';
import 'package:hyshare/app/data/service/auth/service.dart';

class AppInitalizer {
  Future<void> init() async {
    await Future.wait([
      Get.putAsync(() => AuthService().init()),
    ]);

    Get.put(RideModule());
    Get.put(ChatModule());
  }
}
