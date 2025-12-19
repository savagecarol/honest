import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:honest/modules/add/add_controller.dart';

class AddBinding extends Bindings{
  @override
  void dependencies() {
    debugPrint('AddBinding dependencies called');
    Get.put<AddController>(AddController());
  }
}
