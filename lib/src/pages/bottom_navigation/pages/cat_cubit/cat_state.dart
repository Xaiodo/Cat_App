part of 'cat_cubit.dart';

abstract class CatState extends Equatable {
  const CatState({required this.cats, required this.page});

  final List<Cat> cats;
  final int page;

  @override
  List<Object> get props => [cats, page];
}

class CatInitial extends CatState {
  const CatInitial({required super.cats, required super.page});
}

class CatLoading extends CatState {
  const CatLoading({required super.cats, required super.page});
}

class CatLoaded extends CatState {
  const CatLoaded({required super.cats, required super.page});
}

class CatNoInternet extends CatState {
  const CatNoInternet({required super.cats, required super.page});
}

class CatError extends CatState {
  final String message;
  const CatError({
    required this.message,
    required super.cats,
    required super.page,
  });
}
