import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/const/app_strings.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/core/utils/date_util.dart';
import 'package:hive_notes_app/feature/edit_note/view/widget/note_action_button.dart';
import 'package:hive_notes_app/feature/home/view/widget/category_tag.dart';
import 'package:hive_notes_app/feature/view_note/controller/view_note_controller.dart';

class ViewNoteScreen extends StatelessWidget {
  ViewNoteScreen({super.key});

  final ViewNoteController controller = Get.put(ViewNoteController());
  final NoteModel note = Get.arguments as NoteModel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBackButton(
        title: AppStrings.viewNote,
        actions: [
          NoteActionButtons(
            isDark: isDark,
            onCopy: controller.copyNote,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(10)),
            // Title................................
            Text(
              note.title,
              style: globalTextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? Colors.white
                    : AppColors.blackColor,
              ),
            ),

            SizedBox(height: getHeight(12)),

            // Category/ Date.............................
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryTag(label: note.category),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: AppColors.greyColor,
                    ),
                    SizedBox(width: getWidth(6)),
                    Text(
                      DateUtilHelper.formatFull(note.updatedAt),
                      style: globalTextStyle(
                        fontSize: 12,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: getHeight(16)),
            Divider(),
            SizedBox(height: getHeight(5)),

            // Description...............................
            SelectionArea(
              child: Text(
                note.description,
                style: globalTextStyle(
                  fontSize: 14,
                  color: AppColors.greyColor,
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      ),
    );
  }
}