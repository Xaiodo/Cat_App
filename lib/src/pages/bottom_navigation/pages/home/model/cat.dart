import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  const Cat({
    required this.id,
    required this.url,
    required this.fact,
    required this.height,
    required this.width,
    this.isLiked = false,
  });

  final String id;
  final String url;
  final String fact;
  final int height;
  final int width;
  final bool isLiked;

  Cat copyWith({
    String? id,
    String? url,
    String? fact,
    int? height,
    int? width,
    bool? isLiked,
  }) =>
      Cat(
        id: id ?? this.id,
        url: url ?? this.url,
        fact: fact ?? this.fact,
        height: height ?? this.height,
        width: width ?? this.width,
        isLiked: isLiked ?? this.isLiked,
      );

  @override
  List<Object?> get props => [id, url, fact, height, width, isLiked];
}
