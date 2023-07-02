import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';

import '../../services/cats_services/cat_facts_service.dart';
import '../../services/cats_services/cat_images_service.dart';
import '../../services/cats_services/cats_local_service.dart';

class CatsRepository {
  CatsRepository({
    required CatImagesService catImageService,
    required CatFactsService catFactService,
    required CatLocalService catLocalService,
  })  : _catImageService = catImageService,
        _catFactService = catFactService,
        _catLocalService = catLocalService;

  final CatImagesService _catImageService;
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

  Future<List<Cat>> refreshCats() async {
    final newCats = await getRemoteCats(0);
    await _catLocalService.clearCats();
    await _catLocalService.saveCats(newCats);
    return newCats;
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
