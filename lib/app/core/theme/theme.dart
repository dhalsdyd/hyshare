import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyshare/app/core/theme/color_theme.dart';

class FGBPTheme {
  static ThemeData get light => lightTheme;
  static ThemeData get dark => darkTheme;

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: FGBPColors.mainColor,
    ),
    primaryColor: FGBPColors.mainColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      foregroundColor: Colors.black,
      centerTitle: false,
    ),
    fontFamily: "Pretendard",
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: FGBPDarkColors.mainColor,
    ),
    useMaterial3: true,
    primaryColor: FGBPDarkColors.mainColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      foregroundColor: Colors.white,
      centerTitle: false,
    ),
    fontFamily: "Pretendard",
    scaffoldBackgroundColor: Colors.black,
  );
}
