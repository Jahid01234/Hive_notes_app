import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/data/repository/note_repository.dart';
import 'package:share_plus/share_plus.dart';


class EditNoteController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final NoteRepository _repository = NoteRepository();
  late NoteModel note;


  final RxInt selectedColor = 0.obs;
  final RxString selectedCategory = 'General'.obs;
  final RxBool isPinned = false.obs;
  final RxBool isFavourite = false.obs;
  final RxBool isSaving = false.obs;
  final RxBool hasChanges = false.obs;

  final RxInt charCount = 0.obs;
  final RxInt wordCount = 0.obs;

  final RxString titleError = ''.obs;
  final RxString descriptionError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    note = Get.arguments as NoteModel;

    titleController.text = note.title;
    descriptionController.text = note.description;
    selectedColor.value = note.colorValue;
    selectedCategory.value = note.category;
    isPinned.value = note.isPinned;
    isFavourite.value = note.isFavourite;

    _updateCounters();

    titleController.addListener(_onFieldChanged);
    descriptionController.addListener(() {
      _updateCounters();
      _onFieldChanged();
    });
  }

  void _onFieldChanged() {
    hasChanges.value = true;
  }

  void _updateCounters() {
    final text = descriptionController.text;
    charCount.value = text.length;
    wordCount.value = text
        .trim()
        .isEmpty ? 0 : text
        .trim()
        .split(RegExp(r'\s+'))
        .length;
  }

  void selectColor(int colorValue) {
    selectedColor.value = colorValue;
    hasChanges.value = true;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    hasChanges.value = true;
  }

  Future<void> togglePin() async {
    isPinned.value = !isPinned.value;
    await _repository.togglePin(note.id);
  }

  Future<void> toggleFavourite() async {
    isFavourite.value = !isFavourite.value;
    await _repository.toggleFavourite(note.id);
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

  // update note................................................................
  Future<void> updateNote() async {
    if (!validateForm()) {
      return;
    }

    try {
      isSaving.value = true;

      final updatedNote = note.copyWith(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        colorValue: selectedColor.value,
        category: selectedCategory.value,
        isPinned: isPinned.value,
        isFavourite: isFavourite.value,
        updatedAt: DateTime.now(),
      );

      await _repository.updateNote(updatedNote);

      isSaving.value = false;
      hasChanges.value = false;

      Get.back();
      Get.snackbar(
        'Success',
        'Note updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update note',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );

      debugPrint('Save Note Error: $e');
    } finally {
      isSaving.value = false;
      hasChanges.value = false;
    }
  }


  Future<void> deleteNote() async {
    await _repository.deleteNote(note.id);
  }

  // Undo delete - আবার আগের data দিয়ে note টা restore করে দেয়
  Future<void> restoreNote() async {
    await _repository.addNote(note);
  }

  void shareNote() {
    Share.share('${note.title}\n\n${note.description}');
  }

  void copyNote() {
    final text = '${note.title}\n\n${note.description}';
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      'Note copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 1),
    );
  }



  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}