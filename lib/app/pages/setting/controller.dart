import 'package:hyshare/app/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingPageController extends GetxController with StateMixin {
  static SettingPageController get to => Get.find<SettingPageController>(); // add this line

  final InAppReview inAppReview = InAppReview.instance;

  void requestReview() async {
    bool isAvailable = await inAppReview.isAvailable();
    if (isAvailable) {
      await inAppReview.requestReview();
    } else {
      FGBPToast.open("Review is not available");
    }
  }
}
