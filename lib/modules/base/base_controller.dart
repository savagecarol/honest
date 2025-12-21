import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:honest/modules/home/home_controller.dart';

class BaseController extends GetxController {
  final RxInt currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    
    ever(currentIndex, (index) {
      if (index == 0) {
        _refreshHomeData();
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _refreshHomeData() {
    try {
      final homeController = Get.find<HomeController>();
      homeController.loadMyTasks();
    } catch (e) {
      // HomeController not found, ignore
    }
  }
}