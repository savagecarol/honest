import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:honest/modules/home/home_controller.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies() {
    debugPrint('HomeBinding dependencies called');
    Get.put<HomeController>(HomeController());
  }
}
