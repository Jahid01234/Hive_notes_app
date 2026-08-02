import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/empty_state_widget.dart';
import 'package:hive_notes_app/core/route/app_routes.dart';
import 'package:hive_notes_app/core/theme/theme_controller.dart';
import 'package:hive_notes_app/feature/home/controller/home_controller.dart';
import 'package:hive_notes_app/feature/home/view/widget/custom_floating_button.dart';
import 'package:hive_notes_app/feature/home/view/widget/home_header_section.dart';
import 'package:hive_notes_app/feature/home/view/widget/note_card_widget.dart';
import 'package:hive_notes_app/feature/home/view/widget/note_list_header.dart';
import 'package:hive_notes_app/feature/home/view/widget/section_header_widget.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(40)),
            HomeHeaderSection(
                homeController: controller,
                themeController: themeController,
            ),
            SizedBox(height: getHeight(30)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NoteListHeader(controller: controller),
                  SizedBox(height: getHeight(10)),
                  Expanded(
                    child: Obx(() {
                      if (controller.notes.isEmpty) {
                        return EmptyStateWidget();
                      }

                      if (controller.shouldShowSections) {
                        return ListView(
                          padding: EdgeInsets.only(bottom: getHeight(80)),
                          children: [
                            SectionHeaderWidget(
                              title: 'Pinned',
                              icon: Icons.push_pin_rounded,
                              count: controller.pinnedNotes.length,
                            ),
                            ...controller.pinnedNotes.map((note) =>
                                NoteCardWidget(note: note)),
                            if (controller.otherNotes.isNotEmpty) ...[
                              SectionHeaderWidget(
                                title: 'Others',
                                count: controller.otherNotes.length,
                              ),
                              ...controller.otherNotes.map((note) =>
                                  NoteCardWidget(note: note)),
                            ],
                          ],
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.notes.length,
                        itemBuilder: (context, index) {
                          return NoteCardWidget(
                            note: controller.notes[index],
                            homeController: controller,
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addNote);
        },
      ),
    );
  }
}

