import 'package:get/get.dart';
import 'package:honest/modules/base/base_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
     Get.put<BaseController>(BaseController());
  }

}