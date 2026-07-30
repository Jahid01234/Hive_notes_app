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
  final formKey = GlobalKey<FormState>();

  final RxInt selectedColor = AppColors.noteColors.first.value.obs;
  final RxString selectedCategory = 'General'.obs;
  final RxBool isSaving = false.obs;

  // Character & Word counter
  final RxInt charCount = 0.obs;
  final RxInt wordCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
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

  Future<void> saveNote() async {
    if (!formKey.currentState!.validate()) return;

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

    isSaving.value = false;

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
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}