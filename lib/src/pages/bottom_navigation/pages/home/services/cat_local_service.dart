import 'package:hive/hive.dart';

import '../model/cat.dart';

class CatLocalService {
  CatLocalService({required Box box}) : _box = box;

  final Box _box;

  Future<void> saveCats(List<Cat> cats) async {
    final localCats = await getCats();
    localCats.addAll(cats);
    await _box.clear();
    await _box.addAll(localCats);
  }

  Future<void> clearCats() async {
    await _box.clear();
  }

  Future<List<Cat>> getCats() async {
    return _box.values.toList().cast<Cat>();
  }

  Future<void> likeCat(String id) async {
    final cats = _box.values.toList().cast<Cat>();
    final cat = cats.firstWhere((cat) => cat.id == id);
    await _box.putAt(cats.indexOf(cat), cat.copyWith(isLiked: !cat.isLiked));
  }
}
