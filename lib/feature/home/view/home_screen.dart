import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/home/controller/home_controller.dart';
import 'package:hive_notes_app/feature/home/view/widget/custom_floating_button.dart';
import 'package:hive_notes_app/feature/home/view/widget/home_header_section.dart';
import 'package:hive_notes_app/feature/home/view/widget/note_card_widget.dart';
import 'package:hive_notes_app/feature/home/view/widget/note_list_header.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(50)),
            HomeHeaderSection(),
            SizedBox(height: getHeight(50)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NoteListHeader(controller: controller),
                  SizedBox(height: getHeight(10)),
                  Expanded(
                    child: Obx(() {
                      if (controller.notes.isEmpty) {
                        return Center(
                          child: Text(
                            'No notes yet',
                            style: globalTextStyle(
                              fontSize: 14,
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.notes.length,
                        itemBuilder: (context, index) {
                          return NoteCardWidget(
                            note: controller.notes[index],
                            index: index,
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
        onPressed: () {},
      ),
    );
  }
}