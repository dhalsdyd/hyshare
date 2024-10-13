import 'package:hyshare/app/data/service/auth/service.dart';
import 'package:hyshare/app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginMiddleware extends GetMiddleware {
  final AuthService authService = Get.find<AuthService>();

  LoginMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    return authService.isAuthenticated ? null : RouteSettings(name: Routes.login, arguments: {'redirect': route});
  }
}
