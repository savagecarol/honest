import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:honest/core/themes/app_text_styles.dart';

class CustomIconBox extends StatelessWidget {


  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconBox({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),IconButton(onPressed: onPressed, icon:Icon(icon, color: Colors.white,size: 20.h,))
        ],
      ),
    );
  }
}
