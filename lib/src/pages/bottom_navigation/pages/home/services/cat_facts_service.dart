import 'package:dio/dio.dart';

import '../../../../../values/app_constants.dart';

class CatFactsService {
  CatFactsService({required Dio dio}) : _dio = dio;

  final Dio _dio;
  Future<List<String>> getCatFacts(int page) async {
    try {
      final response = await _dio.get(
        catFactsApiUrl,
        queryParameters: {
          'page': page,
        },
      );
      final data = response.data as Map<String, dynamic>;
      final facts = data['data'] as List<dynamic>;
      return facts.map((e) => e['fact'] as String).toList();
    } catch (e) {
      throw Exception('Error getting cat facts: $e');
    }
  }
}
