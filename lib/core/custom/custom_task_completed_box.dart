import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/models/task.dart';

class CustomTaskCompletedBox extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const CustomTaskCompletedBox({
    super.key,
    required this.task,
    this.onTap,
  });

  // Check if task was completed successfully
  bool get isSuccessful {
    if (task.completedAt == null) return false;
    
    // If unlimited, it's always failed (shouldn't complete unlimited tasks)
    if (task.unlimited) return false;
    
    // If no counter set, consider it successful
    if (task.counter == null) return true;
    
    // Calculate target date based on counter and unit
    final targetDate = _calculateTargetDate();
    
    // Success if completed on or after target date
    return task.completedAt!.isAfter(targetDate) || 
           task.completedAt!.isAtSameMomentAs(targetDate);
  }

  DateTime _calculateTargetDate() {
    if (task.counter == null) return task.createdAt;
    
    final unit = task.countUnit?.toLowerCase() ?? 'days';
    final counter = task.counter!;
    
    if (unit.contains('year')) {
      return task.createdAt.add(Duration(days: counter * 365));
    } else if (unit.contains('month')) {
      return task.createdAt.add(Duration(days: counter * 30));
    } else if (unit.contains('week')) {
      return task.createdAt.add(Duration(days: counter * 7));
    } else if (unit.contains('hour')) {
      return task.createdAt.add(Duration(hours: counter));
    } else if (unit.contains('min')) {
      return task.createdAt.add(Duration(minutes: counter));
    } else {
      // Default to days
      return task.createdAt.add(Duration(days: counter));
    }
  }

  String _formatDuration(Duration duration) {
    final totalDays = duration.inDays;
    final years = totalDays ~/ 365;
    final months = (totalDays % 365) ~/ 30;
    final days = (totalDays % 365) % 30;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    List<String> parts = [];

    if (years > 0) {
      parts.add('$years ${years == 1 ? 'year' : 'years'}');
    }
    if (months > 0) {
      parts.add('$months ${months == 1 ? 'month' : 'months'}');
    }
    if (days > 0) {
      parts.add('$days ${days == 1 ? 'day' : 'days'}');
    }
    
    parts.add('$hours ${hours == 1 ? 'hr' : 'hrs'}');
    parts.add('$minutes ${minutes == 1 ? 'min' : 'mins'}');
    parts.add('$seconds ${seconds == 1 ? 'sec' : 'secs'}');
    
    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final success = isSuccessful;
    final completedDuration = task.completedAt != null
        ? task.completedAt!.difference(task.createdAt)
        : Duration.zero;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: success
                ? AppColors.success.withOpacity(0.3)
                : AppColors.error.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with status icon
            Row(
              children: [
                // Success/Fail Icon
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: success ? AppColors.success : AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    success ? Icons.check : Icons.close,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    task.title,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Counter Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Goal Counter (Blue Box)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    task.unlimited
                        ? 'Unlimited'
                        : '${task.counter} ${task.countUnit ?? 'days'}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // Completed Duration (Static)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: success
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: success
                            ? AppColors.success.withOpacity(0.2)
                            : AppColors.error.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 2.h),
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            color: success ? AppColors.success : AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            _formatDuration(completedDuration),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: success ? AppColors.success : AppColors.error,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Status Label
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: success
                    ? AppColors.success.withOpacity(0.15)
                    : AppColors.error.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                success ? 'Successfully Completed' : 'Failed to Complete',
                style: AppTextStyles.caption.copyWith(
                  color: success ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}