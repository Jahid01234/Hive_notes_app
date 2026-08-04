import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/app_primary_button.dart';
import 'package:hive_notes_app/core/global_widgets/color_picker_widget.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';
import 'package:hive_notes_app/feature/folder/view/widget/bottom_sheet_header.dart';
import 'package:hive_notes_app/feature/folder/view/widget/folder_category_selector.dart';


class AddFolderBottomSheet extends StatelessWidget {
  final FolderController controller;

  const AddFolderBottomSheet({
    super.key,
    required this.controller,
  });

  static Future<void> show(BuildContext context, FolderController controller) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddFolderBottomSheet(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: getHeight(600)),
        padding: EdgeInsets.fromLTRB(
            getWidth(20),
            getHeight(14),
            getWidth(20),
            getHeight(30),
        ),
        decoration: BoxDecoration(
          color: isDark
                 ? AppColors.cardDark
                 : AppColors.whiteColor,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(getRadius(24),
              ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(),
              SizedBox(height: getHeight(5)),
              Center(
                child: Text(
                  'Create New Folder',
                  style: globalTextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(height: getHeight(18)),

              // Category label
              Text(
                'Choose Category',
                style: globalTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark
                         ? Colors.white70
                         : AppColors.blackColor.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: getHeight(10)),

              // Category chips (default + custom) + "Add New" chip
              FolderCategorySelector(
                controller: controller,
                isDark: isDark,
              ),

              SizedBox(height: getHeight(20)),

              // Folder color
              Text(
                'Folder Color',
                style: globalTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark
                         ? Colors.white70
                         : AppColors.blackColor.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: getHeight(10)),
              Obx(() => ColorPickerWidget(
                selectedColor: controller.selectedColor.value,
                onColorSelected: controller.selectColor,
                ),
              ),

              SizedBox(height: getHeight(30)),

              AppPrimaryButton(
                text: 'Create Folder',
                onTap: () async {
                  final success = await controller.createFolder();
                  if (success && context.mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}