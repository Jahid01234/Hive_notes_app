import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_categories.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/global_widgets/app_back_button.dart';
import 'package:hive_notes_app/core/global_widgets/custom_text_field.dart';
import 'package:hive_notes_app/core/global_widgets/empty_state_widget.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/core/global_widgets/note_card_widget.dart';
import 'package:hive_notes_app/feature/search/controller/search_controller.dart';
import 'package:hive_notes_app/feature/search/view/widgets/category_card.dart';


class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  final SearchNoteController controller = Get.put(SearchNoteController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBackButton(title: "Search"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeight(16)),
              CustomTextField(
                controller: controller.searchTextController,
                onChanged: controller.onSearchChanged,
                hinText: "Search.....",
                textInputType: TextInputType.text,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.greyColor,
                ),
                suffixIcon: Obx(
                      () => controller.searchQuery.value.isNotEmpty
                      ? InkWell(
                    onTap: controller.clearSearch,
                    child: Icon(
                      Icons.close_rounded,
                      size: getWidth(18),
                      color: AppColors.greyColor,
                    ),
                  )
                      : const SizedBox.shrink(),
                ),
              ),

              SizedBox(height: getHeight(16)),

              // Category filter chips
               Obx(() {
                 final selected = controller.selectedCategory.value;
                 return SizedBox(
                   height: getHeight(38),
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     itemCount: AppCategories.defaultCategories.length + 1,
                     itemBuilder: (context, index) {
                       final category = index == 0 ? 'All' : AppCategories
                           .defaultCategories[index - 1];
                       final isSelected = selected == category;

                       return CategoryCard(
                         category: category,
                         isSelected: isSelected,
                         isDark: isDark,
                         onTap: () {
                           controller.changeCategory(category);
                         },
                       );
                     },
                   ),
                 );
               }),

              SizedBox(height: getHeight(16)),

              // Results count
              Obx(() => Text(
                  controller.isSearching.value || controller.selectedCategory.value != 'All'
                      ? '${controller.searchResults.length} results found'
                      : 'All Notes',
                  style: globalTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(height: getHeight(10)),

              // Results list
              Expanded(
                child: Obx(() {
                  if (controller.searchResults.isEmpty) {
                    return EmptyStateWidget(
                      icon: controller.isSearching.value
                          ? Icons.search_off_rounded
                          : Icons.note_alt_outlined,
                      message: controller.isSearching.value
                          ? 'No notes found for "${controller.searchQuery.value}"'
                          : 'No notes yet',
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: getHeight(20)),
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      return NoteCardWidget(
                        note: controller.searchResults[index],
                        searchController: controller,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}