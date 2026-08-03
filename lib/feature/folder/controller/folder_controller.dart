import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_categories.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/data/repository/note_repository.dart';


class FolderController extends GetxController {
  final NoteRepository _repository = NoteRepository();
  final RxList<NoteModel> allNotes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
    _repository.watchNotes().listen((event) => fetchNotes());
  }

  void fetchNotes() {
    allNotes.value = _repository.getAllNotes();
  }

  // প্রতিটা category তে কতগুলো note আছে
  int noteCountFor(String category) {
    return allNotes.where((n) => n.category == category).length;
  }

  // শুধু যেসব category তে কমপক্ষে ১টা note আছে (screenshot এর মতো "You Have 4 Categories")
  List<CategoryData> get categoriesWithNotes {
    return AppCategories.categoryList.where((c) => noteCountFor(c.name) > 0).toList();
  }

  // যদি ইউজার চায় সব category ই দেখাতে (খালি হলেও)
  List<CategoryData> get allCategories => AppCategories.categoryList;
}