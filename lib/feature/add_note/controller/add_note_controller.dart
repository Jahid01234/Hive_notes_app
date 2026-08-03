import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/data/repository/note_repository.dart';
import 'package:uuid/uuid.dart';


class AddNoteController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final NoteRepository _repository = NoteRepository();

  final RxInt selectedColor = AppColors.noteColors.first.value.obs;
  final RxString selectedCategory = 'General'.obs;
  final RxBool isSaving = false.obs;

  // Character & Word counter
  final RxInt charCount = 0.obs;
  final RxInt wordCount = 0.obs;

  final RxString titleError = ''.obs;
  final RxString descriptionError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is String) {
      selectedCategory.value = Get.arguments as String;
    }
    descriptionController.addListener(_updateCounters);
  }

  void _updateCounters() {
    final text = descriptionController.text;
    charCount.value = text.length;
    wordCount.value = text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
  }

  void selectColor(int colorValue) {
    selectedColor.value = colorValue;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }


  void validateTitle(String value) {
    value = value.trim();

    if (value.isEmpty) {
      titleError.value = 'Title is required';
    } else if (value.length < 3) {
      titleError.value = 'Title must be at least 3 characters';
    } else {
      titleError.value = '';
    }
  }

  void validateDescription(String value) {
    value = value.trim();

    if (value.isEmpty) {
      descriptionError.value = 'Description is required';
    } else if (value.length < 8) {
      descriptionError.value = 'Description must be at least 8 characters';
    } else {
      descriptionError.value = '';
    }
  }

  bool validateForm() {
    validateTitle(titleController.text);
    validateDescription(descriptionController.text);

    return titleError.value.isEmpty &&
        descriptionError.value.isEmpty;
  }


  // save note..................................................................
  Future<void> saveNote() async {
    if (!validateForm()) {
      return;
    }

    try {
      isSaving.value = true;

      final now = DateTime.now();

      final newNote = NoteModel(
        id: const Uuid().v4(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        colorValue: selectedColor.value,
        category: selectedCategory.value,
        isPinned: false,
        isFavourite: false,
        createdAt: now,
        updatedAt: now,
      );

      await _repository.addNote(newNote);

      clearForm();

      Get.back();

      Get.snackbar(
        'Success',
        'Note saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save note',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );

      debugPrint('Save Note Error: $e');
    } finally {
      isSaving.value = false;
    }
  }


  void clearForm(){
    titleController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}