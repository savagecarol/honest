import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:honest/modules/tasks/task_controller.dart';

class TaskBinding extends Bindings{
  @override
  void dependencies() {
    debugPrint('TaskBinding dependencies called');
    Get.put<TaskController>(TaskController());
  }
}
