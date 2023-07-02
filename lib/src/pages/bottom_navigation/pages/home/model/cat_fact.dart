import 'package:equatable/equatable.dart';

class CatFact extends Equatable {
  const CatFact({
    required this.fact,
  });

  final String fact;

  factory CatFact.fromJson(Map<String, dynamic> json) => CatFact(
        fact: json['fact'] as String,
      );

  @override
  List<Object?> get props => [fact];
}
