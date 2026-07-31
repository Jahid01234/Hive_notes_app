import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class NoteActionButtons extends StatelessWidget {
  final bool isDark;

  final RxBool isPinned;
  final RxBool isFavourite;

  final VoidCallback onPinTap;
  final VoidCallback onFavouriteTap;

  final VoidCallback onShare;
  final VoidCallback onCopy;
  final VoidCallback onDelete;

  const NoteActionButtons({
    super.key,
    required this.isDark,
    required this.isPinned,
    required this.isFavourite,
    required this.onPinTap,
    required this.onFavouriteTap,
    required this.onShare,
    required this.onCopy,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width:getWidth(6)),
        // Pin Button
        Obx(() => IconButton(
            icon: Icon(
              isPinned.value
                  ? Icons.push_pin_rounded
                  : Icons.push_pin_outlined,
              color: isPinned.value
                  ? AppColors.primaryColor
                  : (isDark
                  ? AppColors.whiteColor
                  : AppColors.blackColor),
            ),
            onPressed: onPinTap,
          ),
        ),


        // Favourite Button
        Obx(() => IconButton(
            icon: Icon(
              isFavourite.value
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isFavourite.value
                  ? AppColors.errorColor
                  : (isDark
                  ? AppColors.whiteColor
                  : AppColors.blackColor),
            ),
            onPressed: onFavouriteTap,
          ),
        ),


        // More Menu
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert_rounded,
            color: isDark
                ? AppColors.whiteColor
                : AppColors.blackColor,
          ),
          onSelected: (value) {

            switch(value){

              case "share":
                onShare();
                break;

              case "copy":
                onCopy();
                break;

              case "delete":
                onDelete();
                break;
            }

          },
          itemBuilder: (context)=>[
             PopupMenuItem(
              value: "share",
              child: Row(
                children: [
                  Icon(Icons.share_outlined,size:18),
                  SizedBox(width:10),
                  Text(
                    "Share",
                    style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                             ? AppColors.whiteColor
                             : AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),

            PopupMenuItem(
              value:"copy",
              child: Row(
                children:[
                  Icon(Icons.copy_rounded,size:18),
                  SizedBox(width:10),
                  Text(
                    "Copy",
                    style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                             ? AppColors.whiteColor
                             : AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),

             PopupMenuItem(
              value:"delete",
              child: Row(
                children:[
                  Icon(
                    Icons.delete_outline_rounded,
                    size:18,
                    color:AppColors.errorColor,
                  ),
                  SizedBox(width:10),
                  Text(
                    "Delete",
                    style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:AppColors.errorColor,
                     ),
                  ),
                ],
              ),
            ),
          ],
        ),


        SizedBox(width:getWidth(6)),
      ],
    );
  }
}