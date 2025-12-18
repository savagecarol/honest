// lib/app/modules/splash/views/splash_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honest/core/app_colors.dart';
import 'package:honest/core/app_text_styles.dart';
import 'package:honest/modules/splash/splash_controller.dart';
import 'package:shimmer/shimmer.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

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
              AppColors.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.white.withOpacity(0.6),
                child: Column(
                  children: [
                    Text(
                      'Honest',
                      style: AppTextStyles.splash
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}