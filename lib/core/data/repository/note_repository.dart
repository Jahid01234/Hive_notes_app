import 'package:hive/hive.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';


class NoteRepository {
  final Box<NoteModel> _noteBox = Hive.box<NoteModel>('notesBox');

  // CREATE
  Future<void> addNote(NoteModel note) async {
    await _noteBox.put(note.id, note);
  }

  // READ - all notes
  List<NoteModel> getAllNotes() {
    return _noteBox.values.toList();
  }

  // READ - single note
  NoteModel? getNoteById(String id) {
    return _noteBox.get(id);
  }

  // UPDATE
  Future<void> updateNote(NoteModel note) async {
    await _noteBox.put(note.id, note);
  }

  // DELETE
  Future<void> deleteNote(String id) async {
    await _noteBox.delete(id);
  }

  // Pin / Unpin toggle
  Future<void> togglePin(String id) async {
    final note = _noteBox.get(id);
    if (note != null) {
      note.isPinned = !note.isPinned;
      await note.save();
    }
  }

  // Favourite toggle
  Future<void> toggleFavourite(String id) async {
    final note = _noteBox.get(id);
    if (note != null) {
      note.isFavourite = !note.isFavourite;
      await note.save();
    }
  }

  // Clear all
  Future<void> clearAll() async {
    await _noteBox.clear();
  }

  // Listen to box changes (reactive stream) - useful for real-time UI update
  Stream<BoxEvent> watchNotes() {
    return _noteBox.watch();
  }
}