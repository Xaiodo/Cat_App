import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_app/src/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AppInitializing()) {
    on<AppGoToAuthenticationEvent>(onAppGoToAuthenticationEvent);
    on<AppGoToAuthenticatedEvent>(onAppGoToAuthenticatedEvent);
    init();
  }

  late StreamSubscription _authSubscription;

  final AuthRepository _authRepository;

  void onAppGoToAuthenticationEvent(
    AppGoToAuthenticationEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.authentication);
  }

  void onAppGoToAuthenticatedEvent(
    AppGoToAuthenticatedEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.authenticated);
  }

  void init() async {
    final bool loggedIn = await _authRepository.isLoggedIn;
    if (loggedIn) {
      add(AppGoToAuthenticatedEvent());
    } else {
      add(AppGoToAuthenticationEvent());
    }
  }

  void loginWithGoogle() async {
    final bool success = await _authRepository.loginWithGoogle();

    if (success) {
      add(AppGoToAuthenticatedEvent());
    }
  }

  void logout() async {
    await _authRepository.logout();
    add(AppGoToAuthenticationEvent());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
