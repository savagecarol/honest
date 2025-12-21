import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/models/task.dart';

class CustomTaskBox extends StatefulWidget {
  final Task task;
  final String? userName;
  final VoidCallback? onTap;
  final bool isFriendTask;

  const CustomTaskBox({
    super.key,
    required this.task,
    this.userName,
    this.onTap,
    this.isFriendTask = false,
  });

  @override
  State<CustomTaskBox> createState() => _CustomTaskBoxState();
}

class _CustomTaskBoxState extends State<CustomTaskBox> {
  late Timer _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateElapsed();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _calculateElapsed();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateElapsed() {
    _elapsed = DateTime.now().difference(widget.task.createdAt);
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
    
    // Always show time
    parts.add('$hours ${hours == 1 ? 'hr' : 'hrs'}');
    parts.add('$minutes ${minutes == 1 ? 'min' : 'mins'}');
    parts.add('$seconds ${seconds == 1 ? 'sec' : 'secs'}');

    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: widget.task.isCompleted
                ? AppColors.success.withOpacity(0.3)
                : AppColors.primary.withOpacity(0.2),
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
            // Title
            Text(
              widget.task.title,
              style: AppTextStyles.h3.copyWith(
                decoration: widget.task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: widget.task.isCompleted
                    ? AppColors.textSecondary
                    : AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
                    widget.task.unlimited
                        ? 'Unlimited'
                        : '${widget.task.counter} ${widget.task.countUnit ?? 'days'}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // Live Timer (Green Box)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.success.withOpacity(0.2),
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
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            _formatDuration(_elapsed),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.success,
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

            // Friend Name (for friend tasks)
            if (widget.isFriendTask && widget.userName != null) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    widget.userName!,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}