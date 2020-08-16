import 'dart:async';

/// To make sure the events passed are valid. any event must be extended from EventBase.
abstract class EventBase {}

/// Provide EventStream help pass event from logic code to UI code.
mixin EventMixin {
  final StreamController<EventBase> _controller = StreamController<EventBase>();

  Stream<EventBase> get events => _controller.stream;

  /// pass event to UI code.
  void putEvent(EventBase event) {
    _controller.sink.add(event);
  }

  void eventDispose() {
    _controller.close();
  }
}
