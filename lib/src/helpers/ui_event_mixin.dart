import 'package:cat_app/src/models/ui_event.dart';

mixin WithUiEvents<S> {
  List<UiEvent> get events;

  UiEvent? get lastEvent {
    if (events.isEmpty) {
      return null;
    }
    return events.last;
  }

  S updatedEvents(List<UiEvent> events);

  S pushEvent(UiEvent event) => updatedEvents([...events, event]);

  S popEvent(UiEvent event) {
    events.remove(event);
    return updatedEvents(events);
  }
}
