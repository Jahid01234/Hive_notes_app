import 'package:get/get.dart';
import 'package:hive_notes_app/feature/home/model/note_model.dart';

class HomeController extends GetxController{

  // ---- Filter dropdown value shown in the "All Notes" selector ----
  final RxString selectedFilter = 'All Notes'.obs;



  // ---- Reactive list of notes ----
  final RxList<NoteModel> notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyNotes();
  }

  void _loadDummyNotes() {
    notes.addAll([
      NoteModel(
        id: '1',
        title: 'How To Draw A Professional Wireframe?',
        description:
        'For Wireframe Design, You Need To Have A Pen And Paper With You, And Using These Two, You Can Design The Idea You Want On Paper For Web Or Mobile, Just Learn....',
        date: '2020/05/09',
        isNew: true,
      ),
      NoteModel(
        id: '2',
        title: 'Ways To Succeed Early',
        description:
        'Success does not come overnight. Consistency, discipline and the right mindset are what actually take you there over time....',
        date: '2020/05/09',
        isNew: false,
      ),
    ]);
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    // TODO: hook up real filtering logic against `notes`
  }

  void addNote(NoteModel note) => notes.insert(0, note);

  void deleteNote(String id) => notes.removeWhere((n) => n.id == id);
}