import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/pages/onboarding/controller.dart';
import 'package:hyshare/app/widgets/button.dart';
import 'package:hyshare/app/widgets/textfield.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class SecondView extends GetView<OnboardingPageController> {
  const SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FGBPText("기본 정보를 알려주세요.", style: FGBPTextTheme.extraBold24),
                  const SizedBox(height: 16),
                  const FGBPText("닉네임", style: FGBPTextTheme.bold20),
                  FGBPTextField(hintText: "닉네임을 입력해주세요.", controller: controller.nameController),
                  const SizedBox(height: 16),
                  const FGBPText("계좌", style: FGBPTextTheme.bold20),
                  FGBPTextField(hintText: "학번을 입력해주세요.", controller: controller.accountController),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            controller.obx(
              (_) => Obx(
                () => FGBPKeyboardReactiveButton(
                  disabled: !controller.isValidate,
                  onTap: controller.submit,
                  child: const Text("다음", style: TextStyle(color: FGBPColors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
              onLoading: FGBPKeyboardReactiveButton(
                onTap: () {},
                child: const CircularProgressIndicator(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
