import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/const/app_strings.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/global_widgets/app_primary_button.dart';
import 'package:hive_notes_app/core/global_widgets/category_chip_widget.dart';
import 'package:hive_notes_app/core/global_widgets/color_picker_widget.dart';
import 'package:hive_notes_app/core/global_widgets/custom_text_field.dart';
import 'package:hive_notes_app/core/global_widgets/section_label.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/core/utils/date_util.dart';
import 'package:hive_notes_app/core/utils/snackbar_util.dart';
import 'package:hive_notes_app/feature/edit_note/controller/edit_note_controller.dart';
import 'package:hive_notes_app/feature/edit_note/view/widget/note_action_button.dart';


class EditNoteScreen extends StatelessWidget {
  EditNoteScreen({super.key});

  final EditNoteController controller = Get.put(EditNoteController());
  final NoteModel note = Get.arguments as NoteModel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBackButton(
        title: AppStrings.editNote,

        actions: [
          NoteActionButtons(
            isDark: isDark,

            isPinned: controller.isPinned,
            isFavourite: controller.isFavourite,

            onPinTap: controller.togglePin,
            onFavouriteTap: controller.toggleFavourite,

            onShare: controller.shareNote,
            onCopy: controller.copyNote,

            onDelete: (){
              _handleDelete(context, controller);
            },
          ),

        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Last updated info
              Text(
                'Last edited: ${DateUtilHelper.formatFull(note.updatedAt)}',
                style: globalTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),
              ),
              SizedBox(height: getHeight(14)),

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

              Align(
                alignment: Alignment.centerRight,
                child: Obx(
                      () => Text(
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
              SizedBox(height: getHeight(16)),

              // Update button
              Obx(() => AppPrimaryButton(
                  text: 'Update Note',
                  isLoading: controller.isSaving.value,
                  onTap: controller.updateNote,
                ),
              ),
              SizedBox(height: getHeight(20)),
            ],
          ),
        ),
      ),
    );
  }

  // Delete + Undo logic.......................................................
  void _handleDelete(BuildContext context, EditNoteController controller) async {
    final deletedNote = controller.note;
    await controller.deleteNote();
    Get.back();

    SnackBarUtil.showUndoDelete(
      context: Get.context!,
      message: '"${deletedNote.title}" deleted',
      onUndo: () async {
        await controller.restoreNote();
      },
    );
  }
}

