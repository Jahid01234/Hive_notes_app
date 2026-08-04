import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/data/model/folder_model.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/global_widgets/empty_state_widget.dart';
import 'package:hive_notes_app/feature/add_note/view/add_note_screen.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';
import 'package:hive_notes_app/feature/home/view/widget/custom_floating_button.dart';
import 'package:hive_notes_app/feature/home/view/widget/note_card_widget.dart';

class FolderNotesScreen extends StatelessWidget {
  final FolderModel folder;

  FolderNotesScreen({
    super.key,
    required this.folder,
  });

  final FolderController controller = Get.find<FolderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackButton(title: folder.name),
      body: Obx(() {
        final notes =
            controller.allNotes.where((n) => n.category == folder.name).toList()
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
            padding: EdgeInsets.only(
                top: getHeight(12),
                bottom: getHeight(80),
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) => NoteCardWidget(note: notes[index]),
          ),
        );
      }),
      floatingActionButton: CustomFloatingButton(
        onPressed: () => Get.to(() => AddNoteScreen(), arguments: folder.name),
      ),
    );
  }
}
