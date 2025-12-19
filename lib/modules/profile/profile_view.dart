import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/custom_button.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/modules/profile/profile_controller.dart';
import 'package:shimmer/shimmer.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        width: double.infinity,
        child: Obx(() {
          final user = controller.user.value;
          if (user == null) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.5),
                    highlightColor: Colors.white.withOpacity(0.2),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.5),
                    highlightColor: Colors.white.withOpacity(0.2),
                    child: Container(
                      height: 20.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.5),
                    highlightColor: Colors.white.withOpacity(0.2),
                    child: Container(
                      height: 20.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      CircleAvatar(
                        backgroundColor: AppColors.background,
                        radius: 50.r,
                        backgroundImage: user.photoUrl != null
                            ? NetworkImage(user.photoUrl!)
                            : null,
                        child: user.photoUrl == null
                            ? Text(
                                user.name != null && user.name!.isNotEmpty
                                    ? user.name![0].toUpperCase()
                                    : 'U',
                                style: AppTextStyles.h1.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              )
                            : null,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        user.name ?? 'No Name',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        user.email,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Sign Out button pinned at bottom above nav bar
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 120.h, // Space for bottom navigation bar
                  top: 16.h,
                ),
                child: Obx(() {
                  return controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : CustomButton(
                          color: AppColors.textPrimary,
                          label: 'Sign Out',
                          onTap: () async {
                            await controller.signOut();
                          },
                        );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}