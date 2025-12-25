import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/custom_button.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/modules/auth/auth_controller.dart';
import 'package:shimmer/shimmer.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.6)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.textWhite,
                      highlightColor: AppColors.textWhite.withOpacity(0.5),
                      child: Text('Honest', style: AppTextStyles.splash),
                    ),
                  ),
                ),
                  Obx(() {  return controller.isSigningIn.value ? 
                   CustomButton(
                          isLoading: true,
                          backgroundColor: AppColors.textPrimary,
                          labelColor: AppColors.textWhite,
                          label: 'Creating Task...',
                          onTap: (){})         
                  : CustomButton(
                    backgroundColor: AppColors.textPrimary,
                    label: 'Sign In With Google',
                    labelColor: AppColors.textWhite,
                    onTap: () async {
                      await controller.signInWithGoogle();
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
