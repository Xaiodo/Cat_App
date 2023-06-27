import 'package:equatable/equatable.dart';

class CatImage extends Equatable {
  const CatImage({
    required this.id,
    required this.url,
    required this.height,
    required this.width,
  });

  final String id;
  final String url;
  final int height;
  final int width;

  factory CatImage.fromJson(Map<String, dynamic> json) => CatImage(
        id: json['id'] as String,
        url: json['url'] as String,
        height: json['height'] as int,
        width: json['width'] as int,
      );

  @override
  List<Object?> get props => [id, url, height, width];
}
