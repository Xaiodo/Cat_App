import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_app/app/app_bloc/app_ui_events.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/profile/profile_cubit/profile_callback.dart';
import 'package:cat_app/src/repositories/auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../src/helpers/ui_event_mixin.dart';
import '../../src/models/ui_event.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState>
    with ChangeNotifier
    implements ProfileCallback {
  AppBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AppState()) {
    on<AppGoToAuthenticationEvent>(onAppGoToAuthenticationEvent);
    on<AppGoToAuthenticatedEvent>(onAppGoToAuthenticatedEvent);
    on<AppAuthenticationErrorEvent>(onAppAuthenticationErrorEvent);
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

  void onAppAuthenticationErrorEvent(
    AppAuthenticationErrorEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.pushEvent(AppUiEventsShowSnackbar(message: event.message)));
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
    try {
      final bool success = await _authRepository.loginWithGoogle();

      if (success) {
        add(AppGoToAuthenticatedEvent());
      }
    } catch (e) {
      add(AppAuthenticationErrorEvent(message: e.toString()));
    }
  }

  @override
  void onLogout() async {
    await _authRepository.logout();
    add(AppGoToAuthenticationEvent());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
