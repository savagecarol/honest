import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/custom_task_completed_box.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/modules/tasks/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

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
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refreshAll,
              child: CustomScrollView(
                slivers: [
                  // Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Completed Tasks 🎉',
                            style: AppTextStyles.h1.copyWith(
                              color: AppColors.textWhite,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Your achievements and milestones',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textWhite.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 12.h)),

                  // My Completed Tasks List or Empty State
                  controller.myCompletedTasks.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_events_outlined,
                                  size: 80.sp,
                                  color: AppColors.textWhite.withOpacity(0.5),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'No Completed Tasks Yet',
                                  style: AppTextStyles.h3.copyWith(
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Complete your first task!',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textWhite.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final task = controller.myCompletedTasks[index];
                                return CustomTaskCompletedBox(
                                  task: task,
                                  onTap: () {
                                  },
                                );
                              },
                              childCount: controller.myCompletedTasks.length,
                            ),
                          ),
                        ),

                  SliverToBoxAdapter(child: SizedBox(height: 100.h)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}