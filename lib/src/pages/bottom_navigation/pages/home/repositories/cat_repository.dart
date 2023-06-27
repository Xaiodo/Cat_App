import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';

import '../services/cat_facts_service.dart';
import '../services/cat_image_service.dart';

class CatRepository {
  CatRepository({
    required CatImageService catImageService,
    required CatFactsService catFactService,
  })  : _catImageService = catImageService,
        _catFactService = catFactService;

  final CatImageService _catImageService;
  final CatFactsService _catFactService;

  Future<List<Cat>> getCats(int page) async {
    try {
      final catImages = await _catImageService.getCatImages(page);
      final catFacts = await _catFactService.getCatFacts(page);
      return catImages
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
    } catch (e) {
      throw Exception('Error getting cats: $e');
    }
  }
}
