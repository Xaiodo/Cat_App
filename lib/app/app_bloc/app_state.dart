part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {
  const AppState();

  AppState get initializing => AppInitializing();

  AppState get authentication => AppAuthentication();

  AppState get authenticated => AppAuthenticated();

  @override
  List<Object> get props => [];
}

class AppInitializing extends AppState {}

class AppAuthenticated extends AppState {}

class AppAuthentication extends AppState {}
