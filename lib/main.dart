import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hyshare/app/core/theme/theme.dart';
import 'package:hyshare/app/data/initalize.dart';
import 'package:hyshare/app/routes/pages.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:hyshare/app/translation/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hyshare/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppInitalizer().init();

  FlutterNativeSplash.remove();

  FirebaseAnalytics analytics = FirebaseAnalytics.instanceFor(app: Firebase.app());
  FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  runApp(
    GetMaterialApp(
      //unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      initialRoute: Routes.home,
      getPages: AppPages.pages,
      theme: FGBPTheme.light,
      darkTheme: FGBPTheme.dark,
      locale: GetCurrentLocale.currentDeviceLocale,
      fallbackLocale: GetCurrentLocale.fallBackLocale,
      translations: AppTranslations(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [observer],
      //routingCallback
      //GetObserver
    ),
  );
}
