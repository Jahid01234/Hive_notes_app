import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/data/model/folder_model.dart';
import 'package:hive_notes_app/core/global_widgets/custom_dialog.dart';
import 'package:hive_notes_app/core/global_widgets/empty_state_widget.dart';
import 'package:hive_notes_app/core/route/app_routes.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';
import 'package:hive_notes_app/feature/folder/view/widget/add_folder_bottom_sheet.dart';
import 'package:hive_notes_app/feature/folder/view/widget/folder_card.dart';
import 'package:hive_notes_app/feature/folder/view/widget/folder_header_section.dart';

class FolderScreen extends StatelessWidget {
  FolderScreen({super.key});

  final FolderController controller = Get.put(FolderController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeight(16)),
              FolderHeaderSection(
                isDark: isDark,
                onAddTap: () => AddFolderBottomSheet.show(context, controller),
              ),
              SizedBox(height: getHeight(16)),
              Divider(color: isDark ? Colors.white12 : AppColors.lightGreyColor),
              SizedBox(height: getHeight(5)),
              Text(
                'List Folders',
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark
                         ? AppColors.whiteColor
                         : AppColors.blackColor,
                ),
              ),
              SizedBox(height: getHeight(16)),
              Expanded(
                child: Obx(() {
                  if (controller.folders.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.create_new_folder_outlined,
                      message: 'No folders yet\nTap + to create your first folder',
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.only(bottom: getHeight(20)),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: getWidth(14),
                      mainAxisSpacing: getHeight(14),
                      childAspectRatio: 0.95,
                    ),
                    itemCount: controller.folders.length,
                    itemBuilder: (context, index) {
                      final folder = controller.folders[index];
                      final count = controller.noteCountFor(folder.name);

                      return FolderCard(
                        folder: folder,
                        noteCount: count,
                        onTap: () => Get.toNamed(AppRoutes.folderNotes,arguments: folder),
                        onLongPress: () => _showDeleteConfirm(context, controller, folder),
                      );
                    },
                  );
                }),
              ),
              Obx(() => Padding(
                  padding: EdgeInsets.only(bottom: getHeight(16)),
                  child: Center(
                    child: Text(
                      controller.folders.isEmpty
                          ? ''
                          : 'You Have ${controller.folders.length} Folders',
                      style: globalTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, FolderController controller, FolderModel folder) {
    showDialog(
      context: context,
      builder: (_) => CustomDialog(
        title: 'Delete Folder?',
        content: '"${folder.name}" folder will be deleted. The notes inside it will remain in Home.',
        confirmText: 'Delete',
        onConfirm: () {
          controller.deleteFolder(folder);
        },
      ),
    );
  }
}

