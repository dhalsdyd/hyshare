import 'package:hyshare/app/core/middleware/login.dart';
import 'package:hyshare/app/pages/add/binding.dart';
import 'package:hyshare/app/pages/add/page.dart';
import 'package:hyshare/app/pages/detail/binding.dart';
import 'package:hyshare/app/pages/detail/page.dart';
import 'package:hyshare/app/pages/home/binding.dart';
import 'package:hyshare/app/pages/home/page.dart';
import 'package:hyshare/app/pages/login/binding.dart';
import 'package:hyshare/app/pages/login/page.dart';
import 'package:hyshare/app/pages/onboarding/binding.dart';
import 'package:hyshare/app/pages/onboarding/page.dart';
import 'package:hyshare/app/pages/profile/binding.dart';
import 'package:hyshare/app/pages/profile/page.dart';

import 'package:hyshare/app/pages/setting/binding.dart';
import 'package:hyshare/app/pages/setting/page.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomePage(), binding: HomePageBinding(), middlewares: [LoginMiddleware()]),
    GetPage(name: Routes.detail, page: () => const DetailPage(), binding: DetailPageBinding(), middlewares: [LoginMiddleware()]),
    GetPage(name: Routes.profile, page: () => const ProfilePage(), binding: ProfilePageBinding(), middlewares: [LoginMiddleware()]),
    GetPage(name: Routes.add, page: () => const AddPage(), binding: AddPageBinding(), middlewares: [LoginMiddleware()]),
    GetPage(name: Routes.login, page: () => const LoginPage(), binding: LoginPageBinding()),
    GetPage(name: Routes.onboarding, page: () => const OnboardingPage(), binding: OnboardingPageBinding()),
    GetPage(name: Routes.setting, page: () => const SettingPage(), binding: SettingPageBinding(), middlewares: [LoginMiddleware()]),
  ];
}
