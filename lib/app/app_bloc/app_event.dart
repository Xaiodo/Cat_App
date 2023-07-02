part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppGoToAuthenticationEvent extends AppEvent {}

class AppGoToAuthenticatedEvent extends AppEvent {}

class AppAuthenticationErrorEvent extends AppEvent {
  const AppAuthenticationErrorEvent({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
