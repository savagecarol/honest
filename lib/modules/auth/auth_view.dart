import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:honest/core/custom/custom_button.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:shimmer/shimmer.dart';

class AuthView extends StatelessWidget {
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
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.6),
            ],
          )),
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
                    child: Text(
                      'Honest',
                      style: AppTextStyles.splash,
                    ),
                  ),
                ),
              ),
              
                CustomButton(
                  color: AppColors.primaryDark,
                  label: 'Sign In With Google',
                  onTap: ()  {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
