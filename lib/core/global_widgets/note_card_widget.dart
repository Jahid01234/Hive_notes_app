import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';
import 'package:hive_notes_app/feature/home/view/widget/category_tag.dart';
import 'package:hive_notes_app/feature/search/controller/search_controller.dart';
import 'package:intl/intl.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/route/app_routes.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/home/controller/home_controller.dart';


class NoteCardWidget extends StatelessWidget {
  final HomeController? homeController;
  final SearchNoteController? searchController;
  final FolderController? folderController;

  final NoteModel note;

  const NoteCardWidget({
    super.key,
    this.homeController,
    this.searchController,
    this.folderController,
    required this.note,
  });

  void deleteNote() {
    if (homeController != null) {
      homeController!.deleteNote(note.id);
    }

    if (searchController != null) {
      searchController!.deleteNote(note.id);
    }

    if (folderController != null) {
      folderController!.deleteNote(note.id);
    }
  }

  void toggleFavourite() {
    if (homeController != null) {
      homeController!.toggleFavourite(note.id);
    }

    if (searchController != null) {
      searchController!.toggleFavourite(note.id);
    }

    if (folderController != null) {
      folderController!.toggleFavourite(note.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.cardDark : Color(note.colorValue);

    return Padding(
      padding: EdgeInsets.only(bottom: getHeight(12)),
      child: Slidable(
        key: ValueKey(note.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (_) {
                deleteNote();
              },
              backgroundColor: AppColors.errorColor,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline_rounded,
              label: 'Delete',
              borderRadius: BorderRadius.circular(getRadius(16)),
            ),
          ],
        ),

        child: InkWell(
          borderRadius: BorderRadius.circular(getRadius(16)),
          onTap: () {
            Get.toNamed(AppRoutes.viewNote, arguments: note);
          },
          onDoubleTap: (){
            Get.toNamed(AppRoutes.editNote, arguments: note);
          },
          child: Container(
            padding: EdgeInsets.all(getWidth(16)),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(getRadius(16)),
              border: isDark ? Border.all(color: Colors.white12) : null,
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: globalTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),

                    if (note.isPinned)
                      Icon(
                        Icons.push_pin_rounded,
                        size: getWidth(16),
                        color: AppColors.primaryColor,
                      ),
                    SizedBox(width: getWidth(6)),
                    InkWell(
                      onTap: () {
                        toggleFavourite();
                      },
                      child: Icon(
                        note.isFavourite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: getWidth(18),
                        color: note.isFavourite
                            ? AppColors.errorColor
                            : AppColors.greyColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: getHeight(8)),

                Text(
                  note.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: globalTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? Colors.white70
                        : AppColors.blackColor.withValues(alpha: 0.7),
                  ),
                ),

                SizedBox(height: getHeight(12)),

                Row(
                  children: [
                    CategoryTag(label: note.category),
                    const Spacer(),
                    Text(
                      DateFormat('MMM dd, hh:mm a').format(note.updatedAt),
                      style: globalTextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
