import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/app_primary_button.dart';
import 'package:hive_notes_app/core/global_widgets/category_chip_widget.dart';
import 'package:hive_notes_app/core/global_widgets/color_picker_widget.dart';
import 'package:hive_notes_app/core/global_widgets/custom_text_field.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/add_note/controller/add_note_controller.dart';

class AddNoteScreen extends StatelessWidget {
   AddNoteScreen({super.key});

  final AddNoteController controller = Get.put(AddNoteController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: getWidth(18),
              color: isDark ? AppColors.whiteColor : AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Add Note',
          style: globalTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.whiteColor : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                CustomTextField(
                  controller: controller.titleController,
                  hinText: 'Note title...',
                ),
                SizedBox(height: getHeight(16)),

                // Category
                _SectionLabel(text: 'Category'),
                SizedBox(height: getHeight(10)),
                Obx(() => CategoryChipWidget(
                    selectedCategory: controller.selectedCategory.value,
                    onCategorySelected: controller.selectCategory,
                  ),
                ),
                SizedBox(height: getHeight(18)),

                // Color
                _SectionLabel(text: 'Note Color'),
                SizedBox(height: getHeight(10)),
                Obx(() => ColorPickerWidget(
                    selectedColor: controller.selectedColor.value,
                    onColorSelected: controller.selectColor,
                  ),
                ),
                SizedBox(height: getHeight(18)),

                // Description
                _SectionLabel(text: 'Description'),
                SizedBox(height: getHeight(10)),
                Expanded(
                  child: CustomTextField(
                    controller: controller.descriptionController,
                    hinText: 'Write your note here...',
                    maxLines: 100,
                    //v: controller.validateDescription,
                  ),
                ),
                SizedBox(height: getHeight(8)),

                // Character / Word counter
                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                        () => Text(
                      '${controller.wordCount.value} words  •  ${controller.charCount.value} characters',
                      style: globalTextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(16)),

                // Save button
                Obx(() => AppPrimaryButton(
                    text: 'Save Note',
                    //icon: Icons.check_rounded,
                    isLoading: controller.isSaving.value,
                    onTap: controller.saveNote,
                  ),
                ),
                SizedBox(height: getHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: globalTextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white70 : AppColors.blackColor.withOpacity(0.7),
      ),
    );
  }
}