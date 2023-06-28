import 'package:bloc/bloc.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/repositories/cat_repository.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

import '../home/model/cat.dart';

part 'cat_state.dart';

class CatCubit extends Cubit<CatState> {
  CatCubit({
    required CatRepository repository,
    required Connectivity connectivity,
  })  : _catRepository = repository,
        _connectivity = connectivity,
        super(CatInitial(cats: List.empty(), page: 0)) {
    init();
  }

  final Connectivity _connectivity;
  final CatRepository _catRepository;

  List<Cat> get favoriteCats => state.cats.where((cat) => cat.isLiked).toList();

  int get favoriteCatsCount => favoriteCats.length;

  int get allCatsCount => state.cats.length;

  Future<void> init() async {
    try {
      emit(CatLoading(cats: state.cats, page: state.page));
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        final cats = await _catRepository.getLocalCats();
        emit(CatLoaded(cats: cats, page: state.page));
        return;
      }
      final cats = await _catRepository.getRemoteCats(0);
      emit(CatLoaded(cats: cats, page: state.page));
    } catch (e) {
      emit(
        CatError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }

  Future<void> loadMore() async {
    try {
      emit(CatLoading(cats: state.cats, page: state.page));
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(CatNoInternet(cats: state.cats, page: state.page));
        return;
      }
      final cats = await _catRepository.getRemoteCats(state.page + 1);
      emit(CatLoaded(cats: state.cats + cats, page: state.page + 1));
    } catch (e) {
      emit(
        CatError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }

  Future<void> refresh() async {
    try {
      emit(CatLoading(cats: state.cats, page: state.page));
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(CatNoInternet(cats: state.cats, page: state.page));
        return;
      }
      final cats = await _catRepository.getRemoteCats(state.page + 1);
      emit(CatLoaded(cats: cats, page: state.page));
    } catch (e) {
      emit(
        CatError(message: e.toString(), cats: state.cats, page: state.page),
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
      emit(CatLoaded(cats: cats, page: state.page));
    } catch (e) {
      emit(
        CatError(message: e.toString(), cats: state.cats, page: state.page),
      );
    }
  }
}
