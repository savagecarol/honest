import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:honest/modules/taskView/task_view_controller.dart';

class TaskViewBinding extends Bindings{
  @override
  void dependencies() {
    debugPrint('TaskViewBinding dependencies called');
    Get.put<TaskViewController>(TaskViewController());
  }
}