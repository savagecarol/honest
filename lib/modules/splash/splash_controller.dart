import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:honest/routes/app_routes.dart';
import 'package:honest/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    debugPrint('SplashController onInit called');
    _handleAuthState();
  }

  void _handleAuthState() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (_authService.currentUser != null) {
      Get.offAllNamed(Routes.base);
    } else {
      Get.offAllNamed(Routes.signIn);
    }
  }
}
