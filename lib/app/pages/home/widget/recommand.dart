import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class RecommandCard extends StatelessWidget {
  const RecommandCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = !context.isDarkMode ? Colors.white : Colors.black;

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FGBPText("이용 에티켓 매너", style: FGBPTextTheme.bold20),
            const SizedBox(height: 8),
            const FGBPText("1. 정산은 택시 이동 중에 끝내주는 것이 매너!", style: FGBPTextTheme.medium16),
            const FGBPText("2. 택시 이동 중에는 통화를 자제해주세요.", style: FGBPTextTheme.medium16),
            const FGBPText("3. 택시 이동 중에는 음식물을 섭취하지 말아주세요.", style: FGBPTextTheme.medium16),
            const SizedBox(height: 8),
            const FGBPText("이용에 불편함이 없도록 매너를 지켜주세요.", style: FGBPTextTheme.medium16),
            const FGBPText("매너를 지키는 것은 모두에게 편안한 이용을 제공합니다.", style: FGBPTextTheme.medium16),
            const SizedBox(height: 8),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const FGBPText("확인", style: FGBPTextTheme.bold20)),
          ],
        ),
      ),
    );
  }
}
