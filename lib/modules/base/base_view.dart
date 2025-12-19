import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/custom_bottom_bar.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/modules/add/add_view.dart';
import 'package:honest/modules/base/base_controller.dart';
import 'package:honest/modules/home/home_view.dart';
import 'package:honest/modules/profile/profile_view.dart';
import 'package:honest/modules/tasks/task_view.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => controller.currentIndex.value = index,
              children: const [
                HomeView(),
                AddView(),
                TaskView(),
                ProfileView(),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: const CustomBottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}