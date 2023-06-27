import 'package:bloc/bloc.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/repositories/cat_repository.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

import '../model/cat.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required CatRepository repository,
    required Connectivity connectivity,
  })  : _catRepository = repository,
        _connectivity = connectivity,
        super(HomeInitial(cats: List.empty(), page: 0)) {
    init();
  }

  final Connectivity _connectivity;
  final CatRepository _catRepository;

  Future<void> init() async {
    try {
      emit(HomeLoading(cats: state.cats, page: state.page));
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        final cats = await _catRepository.getLocalCats();
        emit(HomeLoaded(cats: cats, page: state.page));
        return;
      }
      final cats = await _catRepository.getRemoteCats(0);
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
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(HomeNoInternet(cats: state.cats, page: state.page));
        return;
      }
      final cats = await _catRepository.getRemoteCats(state.page + 1);
      emit(HomeLoaded(cats: state.cats + cats, page: state.page + 1));
    } catch (e) {
      emit(
        HomeError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }

  Future<void> refresh() async {
    try {
      emit(HomeLoading(cats: state.cats, page: state.page));
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(HomeNoInternet(cats: state.cats, page: state.page));
        return;
      }
      final cats = await _catRepository.getRemoteCats(state.page + 1);
      emit(HomeLoaded(cats: cats, page: state.page));
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
      await _catRepository.likeCat(id);
      emit(HomeLoaded(cats: cats, page: state.page));
    } catch (e) {
      emit(
        HomeError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }
}
