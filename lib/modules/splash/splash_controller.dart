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
    _navigateToNextScreen();
  }

   Future<void> _navigateToNextScreen() async {
    debugPrint('navigation to next screen started');
    await Future.delayed(const Duration(milliseconds: 1500));
    if (_authService.isAuthenticated.value) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.signIn);
    }
  }
}
