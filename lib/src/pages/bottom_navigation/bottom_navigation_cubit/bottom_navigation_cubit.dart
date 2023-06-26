import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(const BottomNavigationInitial(page: BottomNavPage.home));

  void changePage(int index) =>
      emit(state.changePage(BottomNavPage.values[index]));
}
