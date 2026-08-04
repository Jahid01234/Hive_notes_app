import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/data/model/folder_model.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class FolderCard extends StatelessWidget {
  final FolderModel folder;
  final int noteCount;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const FolderCard({
    super.key,
    required this.folder,
    required this.noteCount,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(folder.colorValue);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(getRadius(20)),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: EdgeInsets.all(getWidth(16)),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 1),
            borderRadius: BorderRadius.circular(getRadius(20)),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_rounded,
                  color: AppColors.warningColor,
                  size: getWidth(44),
                ),
                SizedBox(height: getHeight(10)),
                Text(
                  folder.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: globalTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: getHeight(4)),
                Text(
                  '$noteCount Notes',
                  style: globalTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}