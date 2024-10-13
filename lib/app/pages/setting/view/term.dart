import 'package:flutter/material.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class ServiceTermPage extends StatelessWidget {
  const ServiceTermPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Term'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FGBPText("1. 개인 정보의 처리 목적.", style: FGBPTextTheme.bold20),
              FGBPText('''
본 개발자가 작성한 앱은(는) 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.
              
1) 무료 앱에서 AdMob(애드몹) 광고 라이브러리(Google Play Lib)가 필요로 하는 권한 위임을 위해 사용
2) 데이터베이스에서 정보를 가져오기 위해서 사용합니다.
              '''),
              FGBPText("2. 개인 정보 처리 위탁 여부", style: FGBPTextTheme.bold20),
              FGBPText('''본 개발자의 앱은 타 업체에 개인 정보 처리를 위탁하지 않습니다.
              '''),
              FGBPText("3. 정보 주체의 권리, 의무 및 그 행사 방법", style: FGBPTextTheme.bold20),
              FGBPText('''
이용자는 개인 정보 주체로서 언제든지 개인 정보 보호 관련 권리를 행사할 수 있습니다.
다만, 본 앱은 앱 사용자의 사용정보를 수집 및 보유하지 않습니다.
              
앱 기능의 활용에만 사용합니다.
'''),
              FGBPText("4. 처리하는 개인 정보의 항목 작성", style: FGBPTextTheme.bold20),
              FGBPText('''다음의 개인정보 항목을 처리하고 있습니다.
              
android.permission.INTERNET : AdMob 광고를 위해, 데이터베이스에서 기존 정보를 가져오기 위해서 사용합니다.
'''),
              FGBPText("5. 개인 정보의 파기", style: FGBPTextTheme.bold20),
              FGBPText('''원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다.
'''),
              FGBPText("6. 개인 정보의 안전성 확보 조치", style: FGBPTextTheme.bold20),
              FGBPText('''개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있습니다.
              
이 개인정보 처리방침은 2024년 7월 00일부터 적용됩니다.
'''),
            ],
          ),
        ),
      ),
    );
  }
}
