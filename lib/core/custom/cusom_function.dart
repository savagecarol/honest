import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';

void showErrorSnackbar(String title, String message,{SnackPosition position = SnackPosition.TOP}) {
  Get.snackbar(
    '',
    '',
    snackPosition: position,
    padding: EdgeInsets.all(12.w),
    backgroundColor: AppColors.surface.withOpacity(.8),
    colorText: AppColors.textPrimary,
    margin: const EdgeInsets.all(16),
    borderRadius: 5.sp,
    duration: const Duration(seconds: 2),
    titleText: Text(title,style: AppTextStyles.bodyMedium),
    messageText:Text(message,style: AppTextStyles.error),
  );
}