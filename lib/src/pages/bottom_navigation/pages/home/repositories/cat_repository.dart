import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';

import '../services/cat_facts_service.dart';
import '../services/cat_image_service.dart';
import '../services/cat_local_service.dart';

class CatRepository {
  CatRepository({
    required CatImageService catImageService,
    required CatFactsService catFactService,
    required CatLocalService catLocalService,
  })  : _catImageService = catImageService,
        _catFactService = catFactService,
        _catLocalService = catLocalService;

  final CatImageService _catImageService;
  final CatFactsService _catFactService;
  final CatLocalService _catLocalService;

  Future<List<Cat>> getRemoteCats(int page) async {
    try {
      final catImages = await _catImageService.getCatImages(page);
      final catFacts = await _catFactService.getCatFacts(page);
      final List<Cat> cats = catImages
          .map(
            (cat) => Cat(
              id: cat.id,
              url: cat.url,
              height: cat.height,
              width: cat.width,
              fact: catFacts[catImages.indexOf(cat)],
            ),
          )
          .toList();
      await _catLocalService.saveCats(cats);
      return cats;
    } catch (e) {
      throw Exception('Error getting cats: $e');
    }
  }

  Future<List<Cat>> getLocalCats() async {
    try {
      final cats = await _catLocalService.getCats();
      return cats;
    } catch (e) {
      throw Exception('Error getting cats: $e');
    }
  }

  Future<void> likeCat(String id) async {
    try {
      await _catLocalService.likeCat(id);
    } catch (e) {
      throw Exception('Error liking cat: $e');
    }
  }
}
