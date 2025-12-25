import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/custom_button.dart';
import 'package:honest/core/custom/custom_text_field.dart';
import 'package:intl/intl.dart';

import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/modules/taskView/task_view_controller.dart';


class TaskViewPage extends GetView<TaskViewController> {
  const TaskViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: Get.back,
        ),
        title: Text(
          'Task Details',
          style: AppTextStyles.h2.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: controller.shareToInstagram,
          ),
        ],
      ),
      body: Obx(() {
        final task = controller.task.value;

        if (task == null) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 40.h),
          child: Column(
            children: [
              /// =======================
              /// SHAREABLE CARD
              /// =======================
              RepaintBoundary(
                key: controller.repaintKey,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20.w),
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// STATUS
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: task.isCompleted
                              ? Colors.green.withOpacity(0.2)
                              : Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          task.isCompleted ? '✓ Completed' : '○ In Progress',
                          style: AppTextStyles.caption.copyWith(
                            color: task.isCompleted
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      /// TITLE
                      Text(
                        task.title,
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.primary,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      /// DESCRIPTION (ALWAYS SHOWN)
                      Text(
                        'Description',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        task.description?.isNotEmpty == true
                            ? task.description!
                            : 'No description provided',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              task.description?.isNotEmpty == true
                                  ? FontStyle.normal
                                  : FontStyle.italic,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// COUNTER
                      if (!task.unlimited)
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: AppColors.primary,
                                size: 32.sp,
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Progress',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textPrimary
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${task.counter ?? 0} ${task.countUnit ?? ''}',
                                    style: AppTextStyles.h2.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: 20.h),

                      /// DATES
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _DateColumn(
                            label: 'Created',
                            date: task.createdAt,
                            alignEnd: false,
                          ),
                          if (task.completedAt != null)
                            _DateColumn(
                              label: 'Completed',
                              date: task.completedAt!,
                              alignEnd: true,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// =======================
              /// NOTES SECTION
              /// =======================
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: AppTextStyles.h2.copyWith(color: Colors.white),
                    ),

                    SizedBox(height: 16.h),

                    CustomTextField(
                      controller: controller.noteController,
                      hintText: 'Add a note...',
                      maxLines: 3,
                      fillColor: Colors.white,
                      focusedBorderColor: AppColors.primary,
                      textStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    CustomButton(
                      isLoading: controller.isSaving.value,
                      backgroundColor: AppColors.textWhite,
                      label: 'Add Note',
                      labelColor: AppColors.textPrimary,
                      onTap: controller.isSaving.value
                          ? () {}
                          : controller.addNote,
                    ),

                    SizedBox(height: 20.h),

                    /// NOTES LIST
                    if (task.notes.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            'No notes yet',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      )
                    else
                      ...List.generate(task.notes.length, (index) {
                        final note =
                            task.notes[task.notes.length - 1 - index];

                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  note.content,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 20.sp,
                                ),
                                onPressed: () =>
                                    _showDeleteDialog(note.id),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showDeleteDialog(String noteId) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Note',style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete this note?',style: AppTextStyles.bodySmall),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteNote(noteId);
            },
            child:
                const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// =======================
/// DATE WIDGET
/// =======================
class _DateColumn extends StatelessWidget {
  final String label;
  final DateTime date;
  final bool alignEnd;

  const _DateColumn({
    required this.label,
    required this.date,
    required this.alignEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary.withOpacity(0.6),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          DateFormat('MMM dd, yyyy').format(date),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
