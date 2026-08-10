import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/global_widgets/build_bullet_point.dart';
import 'package:hive_notes_app/core/global_widgets/build_contact_info.dart';
import 'package:hive_notes_app/core/global_widgets/last_updated_card.dart';
import 'package:hive_notes_app/core/global_widgets/section_label.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/privacy_policy/view/widget/secret_content_card.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBackButton(title: 'Privacy Policy'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(20)),

                // Last Updated
                LastUpdatedCard(text: "Last Updated: August 07, 2026",),

                SizedBox(height: getHeight(20)),

                // Introduction
                SectionLabel(text: 'Introduction'),
                _buildParagraph(
                  'At Notes App, we are committed to protecting your privacy. This Privacy '
                      'Policy explains what information is collected, how it is used, and how it '
                      'is protected when you use our mobile application.',
                ),

                SizedBox(height: getHeight(20)),

                // Information We Collect
                SectionLabel(text: '1. Information We Collect'),

                SizedBox(height: getHeight(12)),
                _buildSubSectionTitle('1.1 Notes Content',isDark),
                BuildBulletPoint(
                  text: 'The titles, descriptions, categories, and colors of the notes and folders you '
                      'create',
                ),
                BuildBulletPoint(
                  text: 'This content is stored locally on your device only and is never uploaded to '
                      'any server by default',
                ),

                SizedBox(height: getHeight(12)),
                _buildSubSectionTitle('1.2 Device Information',isDark),
                BuildBulletPoint(text: 'Device model and operating system version'),
                BuildBulletPoint(text: 'App version and basic usage data (e.g. crash logs, if enabled)'),

                SizedBox(height: getHeight(12)),
                _buildSubSectionTitle('1.3 Backup Files',isDark),
                BuildBulletPoint(
                  text: 'If you use the Backup feature, a local file containing your notes and folders '
                      'is generated on your device',
                ),
                BuildBulletPoint(
                  text: 'This file is only shared or stored where you choose to save or send it '
                      '(e.g. via a sharing app, cloud drive, or email)',
                ),

                SizedBox(height: getHeight(20)),

                // How We Use Your Information
                SectionLabel(text: '2. How We Use Your Information'),
                _buildParagraph('The limited information collected is used to:'),
                SizedBox(height: getHeight(8)),
                BuildBulletPoint(text: 'Provide and maintain core app functionality'),
                BuildBulletPoint(text: 'Allow you to create, edit, organize, and back up your notes'),
                BuildBulletPoint(text: 'Improve app performance and fix bugs'),
                BuildBulletPoint(text: 'Diagnose and resolve crashes or technical issues'),

                SizedBox(height: getHeight(20)),

                // Information Sharing
                SectionLabel(text: '3. Information Sharing and Disclosure'),
                _buildParagraph(
                  'Notes App does not have a server, and your note content is not transmitted '
                      'to us or any third party as part of normal app usage.',
                ),
                SizedBox(height: getHeight(12)),
                BuildBulletPoint(
                  text: 'Backup Sharing: Backup files are only shared through the destination you '
                      'personally select (e.g. Google Drive, email, messaging apps)',
                ),
                BuildBulletPoint(
                  text: 'Legal Authorities: We may disclose information if required by law, though we '
                      'generally have no access to your note content',
                ),
                BuildBulletPoint(
                  text: 'Service Providers: Basic technical services (e.g. crash reporting, app store '
                      'analytics) may process limited device data',
                ),

                SizedBox(height: getHeight(12)),
                SecretContentCard(),

                SizedBox(height: getHeight(20)),

                // Data Security
                SectionLabel(text: '4. Data Security'),
                _buildParagraph(
                  'Since your notes are stored locally on your device, their security largely '
                      'depends on your device\'s own security settings. We recommend:',
                ),
                SizedBox(height: getHeight(8)),
                BuildBulletPoint(text: 'Keeping your device protected with a lock screen (PIN, password, biometrics)'),
                BuildBulletPoint(text: 'Keeping your operating system and the app updated'),
                BuildBulletPoint(text: 'Safely storing any backup files you export'),
                BuildBulletPoint(text: 'Not sharing backup files with untrusted parties'),

                SizedBox(height: getHeight(20)),

                // Your Rights
                SectionLabel(text: '5. Your Rights and Choices'),
                _buildParagraph('You have full control over your data at all times:'),
                SizedBox(height: getHeight(8)),
                BuildBulletPoint(text: 'View, edit, or delete any note or folder at any time'),
                BuildBulletPoint(text: 'Export your data as a backup file'),
                BuildBulletPoint(text: 'Clear all app data from the Settings screen'),
                BuildBulletPoint(text: 'Uninstall the app to remove all locally stored data'),

                SizedBox(height: getHeight(20)),

                // Data Retention
                SectionLabel(text: '6. Data Retention'),
                _buildParagraph(
                  'Your notes remain on your device for as long as the app is installed or '
                      'until you delete them. Data is permanently removed when you delete a note, '
                      'clear app data, or uninstall the app. Backup files remain wherever you have '
                      'saved them until you delete them yourself.',
                ),

                SizedBox(height: getHeight(20)),

                // Children's Privacy
                SectionLabel(text: '7. Children\'s Privacy'),
                _buildParagraph(
                  'Notes App is not directed at children under 13. We do not knowingly collect '
                      'personal information from children. Since the app primarily stores data '
                      'locally, it can generally be used by any age group under appropriate parental '
                      'guidance.',
                ),

                SizedBox(height: getHeight(20)),

                // Third-Party Services
                SectionLabel(text: '8. Third-Party Services'),
                _buildParagraph(
                  'The app may use third-party services (such as sharing tools or app store '
                      'analytics) that operate under their own privacy policies. We encourage you to '
                      'review the privacy practices of any third-party service you use in connection '
                      'with the app, such as your cloud storage or messaging provider when sharing '
                      'backup files.',
                ),

                SizedBox(height: getHeight(20)),

                // Changes to Policy
                SectionLabel(text: '9. Changes to This Policy'),
                _buildParagraph(
                  'We may update this Privacy Policy from time to time. Any changes will be '
                      'reflected by updating the "Effective Date" on this page. Continued use of the '
                      'app after changes constitutes acceptance of the updated policy.',
                ),

                SizedBox(height: getHeight(20)),

                // Contact
                SectionLabel(text: '10. Contact Us'),
                _buildParagraph(
                  'If you have questions about this Privacy Policy, please contact us:',
                ),
                SizedBox(height: getHeight(12)),
                BuildContactInfo(icon: Icons.email_outlined, text: 'privacy@notesapp.com'),
                SizedBox(height: getHeight(8)),
                BuildContactInfo(icon: Icons.language_outlined, text: 'www.notesapp.com'),

                SizedBox(height: getHeight(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSubSectionTitle(String title, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(left: getWidth(8)),
      child: Text(
        title,
        style: globalTextStyle(
          fontSize: 14,
          color: isDark ? Colors.white70
              : AppColors.blackColor.withValues(alpha: 0.7),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: globalTextStyle(
        fontSize: 14,
        color: AppColors.greyColor,
      ),
    );
  }
}

