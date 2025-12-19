import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

    // Headings
  static TextStyle splash = TextStyle(
    fontSize: 42.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    letterSpacing: 1.5,
  );


  // Headings
  static TextStyle h1 = TextStyle(
    fontSize: 32.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 28.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    letterSpacing: -0.5,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 24.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  static TextStyle h4 = TextStyle(
    fontSize: 20.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  static TextStyle h5 = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  static TextStyle h6 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  // Body Text
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    height: 1.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    height: 1.5,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Special Text
  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle button = TextStyle(
    fontSize: 16.sp,
        fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
    letterSpacing: 0.5,
  );

  static TextStyle overline = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
    height: 1.5,
  );

  // Link
  static TextStyle link = TextStyle(
    fontSize: 14.sp,
        fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // Error
  static TextStyle error = TextStyle(
    fontSize: 14.sp,
        fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );
}