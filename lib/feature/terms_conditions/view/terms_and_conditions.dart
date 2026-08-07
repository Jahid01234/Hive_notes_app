import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/global_widgets/section_label.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/terms_conditions/view/widgets/build_bullet_point.dart';
import 'package:hive_notes_app/feature/terms_conditions/view/widgets/build_contact_info.dart';
import 'package:hive_notes_app/feature/terms_conditions/view/widgets/last_updated_card.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBackButton(title: 'Terms & Conditions'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(20)),

                // Last Updated
                LastUpdatedCard(),

                SizedBox(height: getHeight(20)),

                // Introduction
                SectionLabel(text: '1. Introduction'),
                _buildParagraph(
                  'Welcome to Notes App ("we," "our," or "us"). These Terms and Conditions '
                      '("Terms") govern your access to and use of this mobile application '
                      '(the "App"). By downloading, installing, or using our App, you agree to be '
                      'bound by these Terms. If you do not agree to these Terms, please do not use '
                      'the App.',
                ),

                SizedBox(height: getHeight(20)),

                // Acceptance of Terms
                SectionLabel(text:'2. Acceptance of Terms'),
                _buildParagraph(
                  'By using Notes App, you confirm that you are at least 13 years old or have '
                      'the consent of a parent or legal guardian. Continued use of the App '
                      'constitutes your acceptance of any updates or changes to these Terms.',
                ),

                SizedBox(height: getHeight(20)),

                // Nature of the App
                SectionLabel(text:'3. Nature of the App'),
                _buildParagraph(
                  'Notes App is a personal note-taking application that allows you to create, '
                      'organize, and manage notes and folders on your own device. The App is '
                      'designed primarily for local, offline use.',
                ),
                SizedBox(height: getHeight(8)),
                BuildBulletPoint(text: 'Your notes are stored locally on your device.'),
                BuildBulletPoint(text: 'The App does not automatically upload, sync, or transmit your notes to any '
                      'external server unless you explicitly use a backup or export feature.'),
                BuildBulletPoint(text: 'You are solely responsible for the content you create, store, or manage '
                      'within the App.'),

                SizedBox(height: getHeight(20)),

                // User Responsibilities
                SectionLabel(text:'4. User Responsibilities'),
                _buildParagraph('By using Notes App, you agree to:'),
                SizedBox(height: getHeight(8)),
                BuildBulletPoint(text: 'Use the App only for lawful and personal purposes'),
                BuildBulletPoint(text: 'Not use the App to store or share illegal, harmful, or offensive content'),
                BuildBulletPoint(text: 'Take responsibility for backing up your own data regularly'),
                BuildBulletPoint(text: 'Not attempt to reverse engineer, modify, or tamper with the App'),
                BuildBulletPoint(text: 'Not use the App in any way that could damage or impair its functionality'),

                SizedBox(height: getHeight(20)),

                // Data Storage and Backup
                SectionLabel(text:'5. Data Storage and Backup'),
                _buildParagraph(
                  'Notes App stores your data locally on your device. We strongly recommend '
                      'using the in-app Backup feature regularly to avoid data loss.',
                ),
                SizedBox(height: getHeight(8)),
                _buildSubSectionTitle('5.1 Local Storage',isDark),
                BuildBulletPoint(text: 'All notes and folders are stored on your device and are not accessible to us'),
                BuildBulletPoint(text: 'Uninstalling the App or clearing app data may permanently delete your notes'),
                SizedBox(height: getHeight(8)),
                _buildSubSectionTitle('5.2 Backup and Restore',isDark),
                BuildBulletPoint(text: 'You can export a backup file of your notes at any time from Settings'),
                BuildBulletPoint(text: 'You are responsible for safely storing your backup files'),
                BuildBulletPoint(text: 'We are not responsible for data loss due to device failure, uninstallation, '
                      'or accidental deletion'),

                SizedBox(height: getHeight(20)),

                // Privacy and Data Protection
                SectionLabel(text:'6. Privacy and Data Protection'),
                _buildParagraph(
                  'We respect your privacy. Since Notes App primarily stores data locally on '
                      'your device, we do not collect or have access to the content of your notes. '
                      'For more details on what limited data (if any) is collected, please refer to '
                      'our Privacy Policy.',
                ),

                SizedBox(height: getHeight(20)),

                // Intellectual Property
                SectionLabel(text:'7. Intellectual Property'),
                _buildParagraph(
                  'All content, features, and functionality of the App, including but not '
                      'limited to design, graphics, logos, icons, and software code, are the '
                      'exclusive property of Notes App or its developers and are protected by '
                      'applicable copyright and intellectual property laws.',
                ),

                SizedBox(height: getHeight(20)),

                // Limitation of Liability
                SectionLabel(text:'8. Limitation of Liability'),
                _buildParagraph(
                  'To the fullest extent permitted by law, Notes App shall not be liable for '
                      'any indirect, incidental, or consequential damages, including but not '
                      'limited to loss of data, resulting from:',
                ),
                SizedBox(height: getHeight(8)),
                BuildBulletPoint(text: 'Your access to or use of (or inability to access or use) the App'),
                BuildBulletPoint(text: 'Loss of notes due to device failure, app uninstallation, or data corruption'),
                BuildBulletPoint(text: 'Any unauthorized access to your device or backup files'),
                BuildBulletPoint(text: 'Failure to regularly back up your data'),

                SizedBox(height: getHeight(20)),

                // Termination
                SectionLabel(text:'9. Termination'),
                _buildParagraph(
                  'We reserve the right to discontinue or modify the App at any time. You may '
                      'stop using the App and uninstall it at any time. Please note that '
                      'uninstalling the App will permanently delete all locally stored notes unless '
                      'a backup has been taken.',
                ),

                SizedBox(height: getHeight(20)),

                // Changes to Terms
                SectionLabel(text:'10. Changes to Terms'),
                _buildParagraph(
                  'We reserve the right to modify or replace these Terms at any time. Material '
                      'changes will be communicated through an app update or notice. Continued use '
                      'of the App after such changes constitutes your acceptance of the revised Terms.',
                ),

                SizedBox(height: getHeight(20)),

                // Governing Law
                SectionLabel(text:'11. Governing Law'),
                _buildParagraph(
                  'These Terms shall be governed and construed in accordance with the laws of '
                      'Bangladesh, without regard to its conflict of law provisions.',
                ),

                SizedBox(height: getHeight(20)),

                // Contact Information
                SectionLabel(text:'12. Contact Us'),
                _buildParagraph(
                  'If you have any questions about these Terms and Conditions, please contact us:',
                ),
                SizedBox(height: getHeight(12)),
                BuildContactInfo(icon: Icons.email_outlined, text: 'support@notesapp.com'),
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





