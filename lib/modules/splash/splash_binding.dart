import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:honest/modules/splash/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    debugPrint('SplashBinding dependencies called');
    Get.put<SplashController>(SplashController());
  }
}
