import 'package:bloc/bloc.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/profile/profile_cubit/profile_callback.dart';
import 'package:cat_app/src/repositories/auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../../models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthRepository authRepository,
    required ProfileCallback callback,
  })  : _authRepository = authRepository,
        _callback = callback,
        super(ProfileInitial(user: UserModel.empty())) {
    loadUser();
  }

  final AuthRepository _authRepository;
  final ProfileCallback _callback;

  void loadUser() async {
    emit(ProfileLoading(user: state.user));
    final user = await _authRepository.user;
    emit(ProfileLoaded(user: user));
  }

  void logout() {
    _callback.onLogout();
  }
}
