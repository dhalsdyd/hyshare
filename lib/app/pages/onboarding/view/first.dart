import 'package:flutter/material.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/widgets/button.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FGBPText("하냥쉐어를 소개합니다!", style: FGBPTextTheme.bold20),
                  SizedBox(height: 16),
                  FGBPText("하냥쉐어는 한양대학교 학생들을 위한 택시 합승 서비스입니다.", style: FGBPTextTheme.regularGrey14),
                  SizedBox(height: 16),
                  FGBPText("하냥쉐어를 통해 택시를 함께 타고 싶은 학우들을 찾아보세요.", style: FGBPTextTheme.regularGrey14),
                ],
              ),
            ),
            FGBPMediumTextButton(text: "다음"),
          ],
        ),
      )),
    );
  }
}
