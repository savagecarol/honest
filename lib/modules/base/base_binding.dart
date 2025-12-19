import 'package:get/get.dart';
import 'package:honest/modules/base/base_controller.dart';
import 'package:honest/modules/home/home_controller.dart';
import 'package:honest/modules/add/add_controller.dart';
import 'package:honest/modules/tasks/task_controller.dart';
import 'package:honest/modules/profile/profile_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BaseController>(BaseController());
    Get.put<HomeController>(HomeController());
    Get.put<AddController>(AddController());
    Get.put<TaskController>(TaskController());
    Get.put<ProfileController>(ProfileController());
  }
}