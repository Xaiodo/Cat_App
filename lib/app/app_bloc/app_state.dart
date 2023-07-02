part of 'app_bloc.dart';

enum AppAuthEvent {
  initializing,
  authenticated,
  authentication;

  get isInitializing => this == AppAuthEvent.initializing;

  get isAuthenticated => this == AppAuthEvent.authenticated;

  get isAuthentication => this == AppAuthEvent.authentication;
}

@immutable
class AppState extends Equatable with WithUiEvents {
  const AppState({
    this.events = const [],
    this.authEvent = AppAuthEvent.initializing,
  });

  final AppAuthEvent authEvent;

  @override
  final List<UiEvent> events;

  @override
  updatedEvents(List<UiEvent> events) => AppState(events: events);

  AppState get initializing =>
      const AppState(authEvent: AppAuthEvent.initializing);

  AppState get authentication =>
      const AppState(authEvent: AppAuthEvent.authentication);

  AppState get authenticated =>
      const AppState(authEvent: AppAuthEvent.authenticated);

  @override
  List<Object> get props => [authEvent, events];
}
