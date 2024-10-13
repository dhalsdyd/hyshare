import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/data/models/user.dart';
import 'package:hyshare/app/widgets/snackbar.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.isMe, required this.text, this.copy = false, this.user});

  final bool isMe;
  final bool copy;
  final String text;
  final UserInfo? user;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = Get.width > 475 ? 475 : Get.width;
    Color color = context.isDarkMode ? Colors.white : Colors.black;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: !copy ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        if (!isMe)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (user!.photoUrl.isNotEmpty)
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(user!.photoUrl),
                ),
              if (user!.photoUrl.isEmpty)
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: FGBPColors.subColor,
                ),
              const SizedBox(width: 4),
            ],
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Column(
                children: [
                  Text(user!.name, style: FGBPTextTheme.medium12.copyWith(color: FGBPColors.subColor)),
                  const SizedBox(height: 4),
                ],
              ),
            Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: deviceWidth * 0.7),
                child: CustomPaint(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: isMe ? FGBPColors.mainColor : FGBPColors.subColor, borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      text,
                      textAlign: isMe ? TextAlign.right : TextAlign.left,
                      style: FGBPTextTheme.medium16.copyWith(color: isMe ? Colors.white : Colors.black),
                      maxLines: 100,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (copy)
          Row(
            children: [
              const SizedBox(width: 4),
              GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: text));
                    FGBPSnackBar.open('복사되었습니다.');
                  },
                  child: Icon(
                    Icons.copy,
                    color: color,
                  )),
            ],
          )
      ],
    );
  }
}
