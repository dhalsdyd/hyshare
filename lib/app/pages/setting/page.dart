import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:hyshare/app/pages/setting/controller.dart';
import 'package:hyshare/app/pages/setting/view/term.dart';
import 'package:hyshare/app/widgets/button.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingPageController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = !context.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const FGBPText('Setting'),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: color,
      ),
      backgroundColor: color,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FGBPText("Audio Sound", style: FGBPTextTheme.bold20),
                  const SizedBox(height: 16),
                  const FGBPText("Review", style: FGBPTextTheme.bold20),
                  FGBPMediumTextButton(text: "Rate Us", onTap: controller.requestReview),
                  const SizedBox(height: 16),
                  const FGBPText("Other Apps", style: FGBPTextTheme.bold20),
                  FGBPMediumTextButton(text: "View Other App", onTap: controller.requestReview),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    const FGBPText("VersionInfo 1.0.0 + 1", style: FGBPTextTheme.regular12),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => const ServiceTermPage());
                        },
                        child: const FGBPText("Service Term / Privacy & Policy", style: FGBPTextTheme.regular12)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
