import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/custom_button.dart';
import 'package:honest/core/custom/custom_text_field.dart';
import 'package:honest/core/themes/app_colors.dart';
import 'package:honest/core/themes/app_text_styles.dart';
import 'package:honest/modules/add/add_controller.dart';

class AddView extends GetView<AddController> {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  
                  // Title
                  Text(
                    'Create New Task',
                    style: AppTextStyles.h1.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 24.h),

                  // Title Field - Using CustomTextField
                  CustomTextField(
                    controller: controller.titleController,
                    hintText: 'Enter task title',
                    labelText: 'Title *',
                    focusedBorderColor: AppColors.textPrimary,
                  ),
                  SizedBox(height: 20.h),

                  // Description Field - Using CustomTextField
                  CustomTextField(
                    controller: controller.descriptionController,
                    hintText: 'Enter task description',
                    labelText: 'Description (Optional)',
                    maxLines: 3,
                    focusedBorderColor: AppColors.textPrimary,
                  ),
                  SizedBox(height: 20.h),

                  // Unlimited Switch
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Unlimited',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(() => Switch(
                          value: controller.unlimited.value,
                          onChanged: controller.toggleUnlimited,
                          activeColor: AppColors.textPrimary,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Duration Section (only if not unlimited)
                  Obx(() {
                    if (controller.unlimited.value) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Duration',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        
                        Row(
                          children: [
                            // Unit Dropdown - First
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Obx(() => DropdownButton<String>(
                                  value: controller.countUnit.value,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: AppColors.primary,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.white,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  items: controller.countUnits.map((String unit) {
                                    return DropdownMenuItem<String>(
                                      value: unit,
                                      child: Text(
                                        unit.capitalizeFirst!,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.setCountUnit(newValue);
                                    }
                                  },
                                )),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            
                            // Number Input Field - Using CustomTextField
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                controller: controller.counterController,
                                hintText: '1',
                                showLabel: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                textStyle: AppTextStyles.bodyLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                focusedBorderColor: AppColors.textPrimary,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    final number = int.tryParse(value);
                                    if (number != null && number > 0) {
                                      controller.counter.value = number;
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),

          // Submit Button
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: 100.h,
              top: 16.h,
            ),
            child: Obx(() {
              return controller.isLoading.value
                  ? Center(
                      child: CustomButton(
                        isLoading: true,
                        color: AppColors.textPrimary,
                        label: 'Creating Task...',
                        onTap: () {},
                      ),
                    )
                  : CustomButton(
                      color: AppColors.textPrimary,
                      label: 'Create Task',
                      onTap: controller.submitTask,
                    );
            }),
          ),
        ],
      ),
    );
  }
}