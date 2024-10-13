import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hyshare/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:hyshare/app/pages/login/controller.dart';
import 'package:hyshare/app/widgets/theme_widget.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = !context.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/hanyang1.png"),
                  const SizedBox(height: 8),
                  const FGBPText("분담하는 요금, 나누는 즐거움", style: FGBPTextTheme.bold20),
                ],
              ),
            ),
            //googleSignInButton(),
            GestureDetector(
              onTap: controller.loginWithGoogle,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white),
                  color: color,
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
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/google.svg"),
                      const SizedBox(width: 12),
                      const FGBPText("Login With Google", style: FGBPTextTheme.bold20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
