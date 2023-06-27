import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat_image.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:dio/dio.dart';

class CatImageService {
  const CatImageService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<List<CatImage>> getCatImages(int page) async {
    try {
      final response = await _dio.get(
        catImagesApiUrl,
        queryParameters: {
          'x_api_key': catImagesApiKey,
          'page': page,
        },
      );
      final data = response.data as List<dynamic>;
      return data
          .map((e) => CatImage.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error getting cat images: $e');
    }
  }
}
