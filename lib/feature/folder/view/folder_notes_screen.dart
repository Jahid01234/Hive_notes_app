import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_categories.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/empty_state_widget.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/add_note/view/add_note_screen.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';
import 'package:hive_notes_app/feature/home/view/widget/custom_floating_button.dart';
import 'package:hive_notes_app/feature/home/view/widget/note_card_widget.dart';


class FolderNotesScreen extends StatelessWidget {
  final CategoryData category;
   FolderNotesScreen({
    super.key,
    required this.category,
  });

  final FolderController controller = Get.find<FolderController>();

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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: getWidth(28),
              height: getWidth(28),
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(getRadius(8)),
              ),
              child: Icon(category.icon, color: Colors.white, size: getWidth(15)),
            ),
            SizedBox(width: getWidth(10)),
            Text(
              category.name,
              style: globalTextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final notes = controller.allNotes.where((n) => n.category == category.name).toList()
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

        if (notes.isEmpty) {
          return const EmptyStateWidget(
            message: 'No notes in this folder yet\nTap + to add one',
            icon: Icons.folder_open_rounded,
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: ListView.builder(
            padding: EdgeInsets.only(top: getHeight(12), bottom: getHeight(80)),
            itemCount: notes.length,
            itemBuilder: (context, index) => NoteCardWidget(note: notes[index]),
          ),
        );
      }),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          // এই folder/category প্রি-সিলেক্ট করে Add Note screen এ পাঠানো হচ্ছে
          Get.to(() =>  AddNoteScreen(), arguments: category.name);
        },
      ),
    );
  }
}