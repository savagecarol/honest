import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/custom_task_box.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${controller.currentUser?.name ?? 'User'}! 👋',
                            style: AppTextStyles.h1.copyWith(
                              color: AppColors.textWhite,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Keep up the good work!',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textWhite.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // My Tasks Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'My Tasks',
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                  ),
                  
                  SliverToBoxAdapter(child: SizedBox(height: 12.h)),

                  controller.myTasks.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.task_alt_outlined,
                                  size: 80.sp,
                                  color: AppColors.textWhite.withOpacity(0.5),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Please Create A Task',
                                  style: AppTextStyles.h3.copyWith(
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Start tracking your habits',
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
                                final task = controller.myTasks[index];
                                return CustomTaskBox(
                                  task: task,
                                  onTap: () {
                                    // Navigate to task details if needed
                                  },
                                );
                              },
                              childCount: controller.myTasks.length,
                            ),
                          ),
                        ),

                      
                  if (controller.myTasks.isNotEmpty) ...[
                    SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                    
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Text(
                              'Friends Activities',
                              style: AppTextStyles.h2.copyWith(
                                color: AppColors.textWhite,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.textWhite.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '${controller.friends.length}',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(child: SizedBox(height: 12.h)),

                    // Friend Tasks List
                    controller.friendTasks.isEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 40.h,
                              ),
                              child: Center(
                                child: Text(
                                  'No friend activities yet',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textWhite.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final task = controller.friendTasks[index];
                                  final friendName = controller.getFriendName(
                                    task.userId,
                                  );
                                  return CustomTaskBox(
                                    task: task,
                                    userName: friendName,
                                    isFriendTask: true,
                                    onTap: () {
                                      // Navigate to friend task details if needed
                                    },
                                  );
                                },
                                childCount: controller.friendTasks.length,
                              ),
                            ),
                          ),

                    SliverToBoxAdapter(child: SizedBox(height: 100.h)),
                  ],
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}