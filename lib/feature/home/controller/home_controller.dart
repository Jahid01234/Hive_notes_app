import 'package:get/get.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/data/repository/note_repository.dart';




enum SortType { newest, oldest, titleAZ, titleZA }

enum FilterType { all, pinned, favourite }

class HomeController extends GetxController {
  final NoteRepository _repository = NoteRepository();

  final RxList<NoteModel> allNotes = <NoteModel>[].obs;
  final RxList<NoteModel> notes = <NoteModel>[].obs;

  final Rx<SortType> currentSort = SortType.newest.obs;
  final Rx<FilterType> currentFilter = FilterType.all.obs;
  final RxString selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();

    // Hive box এ কোনো change হলেই automatic UI update হবে
    _repository.watchNotes().listen((event) {
      fetchNotes();
    });
  }

  void fetchNotes() {
    allNotes.value = _repository.getAllNotes();
    applyFilterAndSort();
  }

  void applyFilterAndSort() {
    List<NoteModel> result = List.from(allNotes);

    // Filter by type (pinned / favourite / all)
    if (currentFilter.value == FilterType.pinned) {
      result = result.where((n) => n.isPinned).toList();
    } else if (currentFilter.value == FilterType.favourite) {
      result = result.where((n) => n.isFavourite).toList();
    }

    // Filter by category
    if (selectedCategory.value != 'All') {
      result = result.where((n) => n.category == selectedCategory.value).toList();
    }

    // Sort
    switch (currentSort.value) {
      case SortType.newest:
        result.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case SortType.oldest:
        result.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case SortType.titleAZ:
        result.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case SortType.titleZA:
        result.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        break;
    }

    // Pinned notes সবসময় উপরে থাকবে (favourite/all filter এর ক্ষেত্রে)
    if (currentFilter.value != FilterType.pinned) {
      result.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return 0;
      });
    }

    notes.value = result;
  }

  void changeSort(SortType type) {
    currentSort.value = type;
    applyFilterAndSort();
  }

  void changeFilter(FilterType type) {
    currentFilter.value = type;
    applyFilterAndSort();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    applyFilterAndSort();
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

  int get totalNotes => allNotes.length;
  int get pinnedCount => allNotes.where((n) => n.isPinned).length;
  int get favouriteCount => allNotes.where((n) => n.isFavourite).length;
}