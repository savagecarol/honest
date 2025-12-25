import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final Color backgroundColor;
  final Color labelColor;

  final Widget? preIcon;
  final String label;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;

  const CustomButton({
    Key? key,
    this.isLoading = false,
    required this.backgroundColor,
    this.labelColor = Colors.white,
    this.preIcon,
    required this.label,
    required this.onTap,
    this.borderRadius = 24.0,
    this.padding,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isLoading ? 0.7 : 1,
        child: Container(
          width: double.infinity,
          padding: padding ??
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius.r),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 18.h,
                    width: 18.h,
                    child: CircularProgressIndicator(
                      color: labelColor,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (preIcon != null) ...[
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: preIcon,
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        color: labelColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
