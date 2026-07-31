import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/const/app_strings.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/global_widgets/app_primary_button.dart';
import 'package:hive_notes_app/core/global_widgets/category_chip_widget.dart';
import 'package:hive_notes_app/core/global_widgets/color_picker_widget.dart';
import 'package:hive_notes_app/core/global_widgets/custom_text_field.dart';
import 'package:hive_notes_app/core/global_widgets/section_label.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/add_note/controller/add_note_controller.dart';

class AddNoteScreen extends StatelessWidget {
   AddNoteScreen({super.key});

  final AddNoteController controller = Get.put(AddNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackButton(
        title: AppStrings.addNote,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              SectionLabel(text: 'Title'),
              SizedBox(height: getHeight(10)),
              Obx(() => CustomTextField(
                controller: controller.titleController,
                hinText: 'Note title...',
                errorText: controller.titleError.value.isEmpty
                    ? null
                    : controller.titleError.value,
                onChanged: controller.validateTitle,
              )),
              SizedBox(height: getHeight(16)),

              // Category
              SectionLabel(text: 'Category'),
              SizedBox(height: getHeight(10)),
              Obx(() => CategoryChipWidget(
                  selectedCategory: controller.selectedCategory.value,
                  onCategorySelected: controller.selectCategory,
                ),
              ),
              SizedBox(height: getHeight(18)),

              // Color
              SectionLabel(text: 'Note Color'),
              SizedBox(height: getHeight(10)),
              Obx(() => ColorPickerWidget(
                  selectedColor: controller.selectedColor.value,
                  onColorSelected: controller.selectColor,
                ),
              ),
              SizedBox(height: getHeight(18)),

              // Description
              SectionLabel(text: 'Description'),
              SizedBox(height: getHeight(10)),
              Obx(() => CustomTextField(
                controller: controller.descriptionController,
                hinText: 'Write your note here...',
                maxLines: 10,
                errorText: controller.descriptionError.value.isEmpty
                    ? null
                    : controller.descriptionError.value,
                onChanged: controller.validateDescription,
              )),
              SizedBox(height: getHeight(8)),

              // Character / Word counter
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() => Text(
                    '${controller.wordCount.value} words  •  '
                        '${controller.charCount.value} characters',
                    style: globalTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getHeight(30)),

              // Save button
              Obx(() => AppPrimaryButton(
                  text: 'Save Note',
                  isLoading: controller.isSaving.value,
                  onTap: controller.saveNote,
                ),
              ),
              SizedBox(height: getHeight(40)),
            ],
          ),
        ),
      ),
    );
  }
}

