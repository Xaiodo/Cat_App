part of 'bottom_navigation_cubit.dart';

enum BottomNavPage { home, favorites, profile }

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState({required this.page});

  final BottomNavPage page;

  BottomNavigationState changePage(BottomNavPage page) =>
      BottomNavigationUpdated(page: page);

  @override
  List<Object> get props => [page];
}

class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial({required super.page});
}

class BottomNavigationUpdated extends BottomNavigationState {
  const BottomNavigationUpdated({required super.page});
}
