import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_categories.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/data/model/folder_model.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/data/repository/custom_category_repository.dart';
import 'package:hive_notes_app/core/data/repository/folder_repository.dart';
import 'package:hive_notes_app/core/data/repository/note_repository.dart';
import 'package:uuid/uuid.dart';


class FolderController extends GetxController {
  final FolderRepository _folderRepository = FolderRepository();
  final NoteRepository _noteRepository = NoteRepository();
  final CustomCategoryRepository _customCategoryRepository = CustomCategoryRepository();

  final RxList<FolderModel> folders = <FolderModel>[].obs;
  final RxList<NoteModel> allNotes = <NoteModel>[].obs;

  final RxList<String> categoryOptions = <String>[].obs;

  final TextEditingController folderNameController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();
  final RxString selectedCategoryOption = ''.obs;
  final RxInt selectedColor = AppColors.noteColors[6].value.obs;
  final RxBool isAddingNewCategory = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    _loadCategoryOptions();
    _folderRepository.watchFolders().listen((_) => fetchData());
    _noteRepository.watchNotes().listen((_) => fetchData());
  }

  void fetchData() {
    folders.value = _folderRepository.getAllFolders();
    allNotes.value = _noteRepository.getAllNotes();
  }

  void _loadCategoryOptions() {
    final custom = _customCategoryRepository.getCustomCategories();
    final merged = [...AppCategories.defaultCategories, ...custom];
    // duplicate বাদ (case-insensitive)
    final seen = <String>{};
    categoryOptions.value = merged.where((e) => seen.add(e.toLowerCase())).toList();
  }

  int noteCountFor(String folderName) {
    return allNotes.where((n) => n.category == folderName).length;
  }


  void selectCategoryOption(String category) {
    selectedCategoryOption.value = category;
    folderNameController.text = category;
    isAddingNewCategory.value = false;
  }


  void toggleAddNewCategory() {
    isAddingNewCategory.value = !isAddingNewCategory.value;
    if (!isAddingNewCategory.value) newCategoryController.clear();
  }

  // submit category...........................................................
  Future<void> submitNewCategory() async {
    final name = newCategoryController.text.trim();
    if (name.isEmpty) return;

    final exists = categoryOptions.any((e) => e.toLowerCase() == name.toLowerCase());
    if (!exists) {
      await _customCategoryRepository.addCustomCategory(name);
      _loadCategoryOptions();
    }

    selectCategoryOption(name);
    newCategoryController.clear();
    isAddingNewCategory.value = false;
  }

  void selectColor(int colorValue) {
    selectedColor.value = colorValue;
  }

  // create folder..........................................................
  Future<bool> createFolder() async {
    final name = folderNameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
          'Error', 'Please select or create a category',
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.whiteColor,
      );
      return false;
    }

    final exists = folders.any((f) => f.name.toLowerCase() == name.toLowerCase());
    if (exists) {
      Get.snackbar(
          'Error', 'A folder with this name already exists',
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.whiteColor,
      );
      return false;
    }

    final folder = FolderModel(
      id: const Uuid().v4(),
      name: name,
      colorValue: selectedColor.value,
      createdAt: DateTime.now(),
    );

    await _folderRepository.addFolder(folder);


    folderNameController.clear();
    selectedCategoryOption.value = '';
    selectedColor.value = AppColors.noteColors[6].value;
    isAddingNewCategory.value = false;

    return true;
  }

  Future<void> toggleFavourite(String id) async {
    await _noteRepository.toggleFavourite(id);
  }

  Future<void> deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
  }

  // Deleted folder..........................................................
  Future<void> deleteFolder(FolderModel folder) async {
    await _folderRepository.deleteFolder(folder.id);
  }

  @override
  void onClose() {
    folderNameController.dispose();
    newCategoryController.dispose();
    super.onClose();
  }
}