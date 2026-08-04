import 'package:hive/hive.dart';

class CustomCategoryRepository {
  final Box _settingsBox = Hive.box('settingsBox');
  static const String _key = 'customCategories';

  List<String> getCustomCategories() {
    final data = _settingsBox.get(_key, defaultValue: <String>[]);
    return List<String>.from(data);
  }

  Future<void> addCustomCategory(String name) async {
    final list = getCustomCategories();
    if (!list.any((e) => e.toLowerCase() == name.toLowerCase())) {
      list.add(name);
      await _settingsBox.put(_key, list);
    }
  }

  Future<void> removeCustomCategory(String name) async {
    final list = getCustomCategories();
    list.removeWhere((e) => e.toLowerCase() == name.toLowerCase());
    await _settingsBox.put(_key, list);
  }
}