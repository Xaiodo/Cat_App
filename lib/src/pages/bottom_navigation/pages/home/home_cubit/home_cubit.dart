import 'package:bloc/bloc.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/repositories/cat_repository.dart';
import 'package:equatable/equatable.dart';

import '../model/cat.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(CatRepository repository)
      : _catRepository = repository,
        super(HomeInitial(cats: List.empty(), page: 0)) {
    init();
  }

  final CatRepository _catRepository;

  Future<void> init() async {
    try {
      emit(HomeLoading(cats: state.cats, page: state.page));
      final cats = await _catRepository.getCats(0);
      emit(HomeLoaded(cats: cats, page: state.page));
    } catch (e) {
      emit(
        HomeError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }

  Future<void> loadMore() async {
    try {
      emit(HomeLoading(cats: state.cats, page: state.page));
      final cats = await _catRepository.getCats(state.page + 1);
      emit(HomeLoaded(cats: state.cats + cats, page: state.page + 1));
    } catch (e) {
      emit(
        HomeError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }

  Future<void> likeCat(String id) async {
    try {
      final cats = state.cats.map((cat) {
        if (cat.id == id) {
          return cat.copyWith(isLiked: !cat.isLiked);
        }
        return cat;
      }).toList();
      emit(HomeLoaded(cats: cats, page: state.page));
    } catch (e) {
      emit(
        HomeError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }
}
