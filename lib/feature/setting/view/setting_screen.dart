import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/global_widgets/custom_dialog.dart';
import 'package:hive_notes_app/core/global_widgets/section_label.dart';
import 'package:hive_notes_app/core/route/app_routes.dart';
import 'package:hive_notes_app/core/theme/theme_controller.dart';
import 'package:hive_notes_app/feature/setting/controller/setting_controller.dart';
import 'package:hive_notes_app/feature/setting/view/widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.put(SettingsController());
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackButton(
               title: 'Settings',
               showBackButton: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(20),
              vertical: getHeight(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance
              SectionLabel(text: 'Appearance'),
              SizedBox(height: getHeight(6)),
              Obx(() => SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                trailing: Switch(
                  value: themeController.isDarkMode.value,
                  activeThumbColor: AppColors.whiteColor,
                  activeTrackColor: AppColors.primaryColor,
                  inactiveThumbColor: AppColors.whiteColor,
                  inactiveTrackColor: AppColors.greyColor.withValues(alpha: 0.3),
                  trackOutlineColor: WidgetStateColor.transparent,
                  onChanged: (_) => themeController.toggleTheme(),
                ),
              )),
              Divider(height: getHeight(35)),



              // Data
              SectionLabel(text: 'Data & Backup'),
              SizedBox(height: getHeight(6)),
              SettingsTile(
                icon: Icons.backup_outlined,
                title: 'Backup Notes',
                onTap: () {
                  controller.backupNotes();
                },
              ),
              SettingsTile(
                icon: Icons.restore_outlined,
                title: 'Restore Notes',
                onTap: () {
                  controller.restoreNotes();
                },
              ),
              SettingsTile(
                icon: Icons.delete_sweep_outlined,
                title: 'Clear All Data',
                iconColor: AppColors.errorColor,
                onTap: () {
                  _showClearDataConfirm(context, controller);
                },
              ),
              Divider(height: getHeight(35)),


              // About
              SectionLabel(text: 'About'),
              SizedBox(height: getHeight(6)),
              SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'Terms & Conditions',
                onTap: () {
                  Get.toNamed(AppRoutes.termsAndConditions);
                },
              ),

              SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {

                },
              ),
              SettingsTile(
                showArrow: false,
                icon: Icons.info_outline_rounded,
                title: 'About App',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  controller.appVersion;
                },
              ),
              SizedBox(height: getHeight(30)),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearDataConfirm(BuildContext context, SettingsController controller) {
    showDialog(
      context: context,
      builder: (_) => CustomDialog(
        title: 'Clear All Data?',
        content: 'This will permanently delete all your notes and folders.'
                 ' This action cannot be undone.',
        confirmText: 'Clear All',
        confirmColor: AppColors.errorColor,
        onConfirm: controller.clearAllData,
      ),
    );
  }
}