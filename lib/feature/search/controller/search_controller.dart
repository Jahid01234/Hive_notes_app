import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/data/repository/note_repository.dart';


class SearchNoteController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final NoteRepository _repository = NoteRepository();
  final RxList<NoteModel> allNotes = <NoteModel>[].obs;
  final RxList<NoteModel> searchResults = <NoteModel>[].obs;

  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();

    searchTextController.addListener(() {
      searchQuery.value = searchTextController.text;
      applySearchMethod();
    });


    _repository.watchNotes().listen((event) {
      allNotes.value = _repository.getAllNotes();
      applySearchMethod();
    });
  }

  void loadNotes() {
    allNotes.assignAll(
      _repository.getAllNotes(),
    );

    applySearchMethod();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    applySearchMethod();
  }

  void onSearchChanged(String value) {
    applySearchMethod();
  }


  Future<void> togglePin(String id) async {
    await _repository.togglePin(id);
  }

  Future<void> toggleFavourite(String id) async {
    await _repository.toggleFavourite(id);
  }

  Future<void> deleteNote(String id) async {
    await _repository.deleteNote(id);
  }

  // search method..............................................................
  void applySearchMethod() {
    final query = searchQuery.value.trim().toLowerCase();

    isSearching.value = query.isNotEmpty;

    List<NoteModel> results = List.from(allNotes);

    // Category filter
    if (selectedCategory.value != 'All') {
      results = results.where((n) => n.category == selectedCategory.value).toList();
    }


    if (query.isNotEmpty) {
      results = results.where((note) {
        final titleMatch = note.title.toLowerCase().contains(query);
        final descMatch = note.description.toLowerCase().contains(query);
        return titleMatch || descMatch;
      }).toList();
    }

    results.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    searchResults.value = results;
  }


  void clearSearch() {
    searchTextController.clear();
    searchQuery.value = '';
    isSearching.value = false;
    applySearchMethod();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}