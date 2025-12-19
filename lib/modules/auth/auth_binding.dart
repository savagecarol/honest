import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honest/modules/auth/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    debugPrint('AuthBinding dependencies called');
    Get.put<AuthController>(AuthController());
    
  }

}