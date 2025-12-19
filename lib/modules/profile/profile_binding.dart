import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:honest/modules/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('ProfileBinding dependencies called');
    Get.put<ProfileController>(ProfileController());
  }

}