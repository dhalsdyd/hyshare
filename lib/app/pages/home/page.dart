import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:hyshare/app/data/models/chat.dart';
import 'package:hyshare/app/data/models/user.dart';
import 'package:hyshare/app/pages/home/controller.dart';
import 'package:hyshare/app/pages/home/widget/chat_card.dart';
import 'package:hyshare/app/pages/home/widget/share_card.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:hyshare/app/widgets/textfield.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = !context.isDarkMode ? Colors.white : Colors.black;
    Color reverseColor = context.isDarkMode ? Colors.white : Colors.black;
    Color borderColor = context.isDarkMode ? Colors.white : Colors.white;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FGBPText(
          '하냥쉐어',
          style: FGBPTextTheme.extraBold24,
        ),
        backgroundColor: color,
      ),
      floatingActionButton: Obx(() => !controller.isChat
          ? ExpandableFab(
              key: key,
              type: ExpandableFabType.up,
              childrenAnimation: ExpandableFabAnimation.none,
              distance: 70,
              children: [
                FloatingActionButton(
                    heroTag: "Add",
                    onPressed: () {
                      Get.toNamed(Routes.add);
                    },
                    child: const Icon(Icons.add)),
                FloatingActionButton(
                    heroTag: "Person",
                    onPressed: () {
                      Get.toNamed(Routes.profile);
                    },
                    child: const Icon(Icons.person)),
              ],
            )
          : Container()),
      floatingActionButtonLocation: ExpandableFab.location,
      backgroundColor: color,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => controller.isChat ? _chat(color, borderColor, reverseColor) : _home(color, borderColor, reverseColor)),
      )),
    );
  }

  Column _chat(Color color, Color borderColor, Color reverseColor) {
    return Column(
      children: [
        ShareCard(ride: controller.selectedRide!),
        Expanded(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => ListView.separated(
                        itemBuilder: (context, index) {
                          Message chat = controller.chats[index];
                          if (chat.senderId == "system") {
                            return Center(child: FGBPText(chat.message, style: FGBPTextTheme.medium12));
                          }

                          UserInfo user = controller.chatModule.selectedChat.value!.users.firstWhere((element) => element.userId == chat.senderId,
                              orElse: () => UserInfo(
                                    userId: "system",
                                    name: "나간 유저",
                                    photoUrl: "",
                                    fcmToken: "",
                                  ));

                          return ChatItem(
                            isMe: controller.isMe(chat.senderId),
                            text: chat.message,
                            user: user,
                            copy: controller.isAccount(chat.message),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemCount: controller.chats.length,
                      )))),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            FGBPTextField(
              controller: controller.chatController,
              hintText: "메시지를 입력하세요",
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: FGBPColors.mainColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: controller.obx(
                  (_) => IconButton(
                    onPressed: () {
                      controller.sendMessage();
                    },
                    icon: const Icon(Icons.send),
                    color: Colors.white,
                  ),
                  onLoading: IconButton(onPressed: () {}, icon: const CircularProgressIndicator()),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const FGBPText("Copyright 2024 Hyshare. All rights reserved."),
      ],
    );
  }

  Column _home(Color color, Color borderColor, Color reverseColor) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await launchUrl(Uri.parse("https://hanyangshare.notion.site/11e221f1331280a3ab63f25447c1a833"));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(child: FGBPText("메뉴얼 및 공지사항", style: FGBPTextTheme.boldWhite14)),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (controller.rides.isEmpty) {
                      return const Center(child: FGBPText("올라온 합승 요청이 없습니다.", style: FGBPTextTheme.medium16));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return ShareCard(ride: controller.rides[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 16,
                            ),
                        itemCount: controller.rides.length);
                  }))),
        ),
        const SizedBox(height: 16),
        const FGBPText("Copyright 2024 Hyshare. All rights reserved."),
      ],
    );
  }
}
