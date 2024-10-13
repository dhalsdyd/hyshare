import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/pages/profile/controller.dart';
import 'package:hyshare/app/widgets/button.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    controller.obx(
                      (_) => CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(controller.user.value!.photoUrl),
                      ),
                      onLoading: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    controller.obx(
                      (_) => Text(
                        controller.user.value!.nickname,
                        style: const TextStyle(fontSize: 24),
                      ),
                      onLoading: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "계좌 관리",
                          style: FGBPTextTheme.bold20.copyWith(color: FGBPColors.mainColor),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const FGBPText(
                                        "계좌번호 변경",
                                        style: FGBPTextTheme.bold20,
                                      ),
                                      TextField(
                                        controller: controller.accountController,
                                        decoration: const InputDecoration(
                                          hintText: "계좌번호를 입력해주세요",
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      FGBPMediumTextButton(
                                        text: "확인",
                                        onTap: controller.updatePaymentInfo,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.edit,
                            color: FGBPColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                    controller.obx(
                      (_) => Text(
                        controller.user.value!.paymentInfo,
                        style: const TextStyle(fontSize: 24),
                      ),
                      onLoading: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 16),
                    // Text(
                    //   "경고 횟수",
                    //   style: FGBPTextTheme.bold20.copyWith(color: FGBPColors.mainColor),
                    // ),
                    // controller.obx(
                    //   (_) => Text(
                    //     controller.user.value!.warningCount.toString(),
                    //     style: const TextStyle(fontSize: 24),
                    //   ),
                    //   onLoading: Shimmer.fromColors(
                    //     baseColor: Colors.grey[300]!,
                    //     highlightColor: Colors.grey[100]!,
                    //     child: Container(
                    //       width: 100,
                    //       height: 20,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            //FGBPMediumTextButton(text: "Web Noti Test", onTap: controller.getFcmToken),
            FGBPMediumTextButton(text: "로그아웃", onTap: controller.logout),
          ],
        ),
      )),
    );
  }
}
