import '../../src/models/ui_event.dart';

class AppUiEventsShowSnackbar extends UiEvent {
  const AppUiEventsShowSnackbar({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}
