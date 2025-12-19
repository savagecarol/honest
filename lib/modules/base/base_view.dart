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
      backgroundColor: AppColors.primary, // Set scaffold background
      body: SafeArea(
        bottom: false, // Allow bottom bar to float over safe area
        child: Stack(
          children: [
            // Main content with gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.6),
                  ],
                ),
              ),
              child: Obx(
                () => IndexedStack(
                  index: controller.currentIndex.value,
                  children: const [
                    HomeView(),
                    AddView(),
                    TaskView(),
                    ProfileView(),
                  ],
                ),
              ),
            ),
            // Floating bottom bar
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