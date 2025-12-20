import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/modules/base/base_controller.dart';

class CustomBottomBar extends StatelessWidget {
    const CustomBottomBar({Key? key});
  @override
  Widget build(BuildContext context) {
    final BaseController controller = Get.find<BaseController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h,horizontal: 12.w),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomBarItem(
              icon: Icons.home,
              index: 0,
              isSelected: controller.currentIndex.value == 0,
              onTap: () => controller.changeIndex(0),
            ),
            _BottomBarItem(
              icon: Icons.add_circle,
              index: 1,
              isSelected: controller.currentIndex.value == 1,
              onTap: () => controller.changeIndex(1),
            ),
            _BottomBarItem(
              icon: Icons.check_circle,
              index: 2,
              isSelected: controller.currentIndex.value == 2,
              onTap: () => controller.changeIndex(2),
            ),
            _BottomBarItem(
              icon: Icons.person,
              index: 3,
              isSelected: controller.currentIndex.value == 3,
              onTap: () => controller.changeIndex(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.icon,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 28.sp,
        color: isSelected
            ? Colors.white
            : Colors.white.withOpacity(0.5),
      ),
    );
  }
}
