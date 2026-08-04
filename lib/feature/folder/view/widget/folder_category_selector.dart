import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/custom_text_field.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';

class FolderCategorySelector extends StatelessWidget {
  final FolderController controller;
  final bool isDark;

  const FolderCategorySelector({
    super.key,
    required this.controller,
    required this.isDark,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Wrap(
            spacing: getWidth(8),
            runSpacing: getHeight(8),
            children: [
              ...controller.categoryOptions.map((category) {
                final isSelected =
                    controller.selectedCategoryOption.value == category;

                return GestureDetector(
                  onTap: () => controller.selectCategoryOption(category),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: getWidth(14),
                      vertical: getHeight(8),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : (isDark
                          ? Colors.white10
                          : AppColors.lightGreyColor),
                      borderRadius: BorderRadius.circular(getRadius(20)),
                    ),
                    child: Text(
                      category,
                      style: globalTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? AppColors.whiteColor
                            : (isDark
                            ? Colors.white70
                            : AppColors.blackColor),
                      ),
                    ),
                  ),
                );
              }),

              // Add New Button...................
              GestureDetector(
                onTap: controller.toggleAddNewCategory,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(14),
                    vertical: getHeight(8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getRadius(20)),
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: getWidth(14),
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: getWidth(4)),
                      Text(
                        'Add New',
                        style: globalTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        Obx(() => controller.isAddingNewCategory.value
              ? Padding(
            padding: EdgeInsets.only(top: getHeight(14)),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.newCategoryController,
                    hinText: 'New category name...',
                  ),
                ),
                SizedBox(width: getWidth(8)),
                InkWell(
                  borderRadius: BorderRadius.circular(getRadius(12)),
                  onTap: controller.submitNewCategory,
                  child: Container(
                    padding: EdgeInsets.all(getWidth(14)),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                      BorderRadius.circular(getRadius(12)),
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: getWidth(18),
                    ),
                  ),
                ),
              ],
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}