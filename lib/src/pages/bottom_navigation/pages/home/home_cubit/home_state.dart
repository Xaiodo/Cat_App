part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState({required this.cats, required this.page});

  final List<Cat> cats;
  final int page;

  @override
  List<Object> get props => [cats, page];
}

class HomeInitial extends HomeState {
  const HomeInitial({required super.cats, required super.page});
}

class HomeLoading extends HomeState {
  const HomeLoading({required super.cats, required super.page});
}

class HomeLoaded extends HomeState {
  const HomeLoaded({required super.cats, required super.page});
}

class HomeError extends HomeState {
  final String message;
  const HomeError({
    required this.message,
    required super.cats,
    required super.page,
  });
}
