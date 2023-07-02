import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cat.g.dart';

@HiveType(typeId: 1)
class Cat extends Equatable {
  const Cat({
    required this.id,
    required this.url,
    required this.fact,
    required this.height,
    required this.width,
    this.isLiked = false,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String fact;
  @HiveField(3)
  final int height;
  @HiveField(4)
  final int width;
  @HiveField(5)
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
