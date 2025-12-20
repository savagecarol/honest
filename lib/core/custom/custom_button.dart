import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:honest/core/themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final Color color;
  final Widget? preIcon;
  final String label;
  final VoidCallback onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    Key? key,
    this.isLoading = false,
    required this.color,
    this.preIcon,
    required this.label,
    required this.onTap,
    this.borderRadius = 5.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
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
        child:
            isLoading
                ? Center(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(4),
                    child: SizedBox(
                      height: 16.h,
                      width: 16.h,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (preIcon != null) ...[
                      SizedBox(height: 24.h, width: 24.w, child: preIcon),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
