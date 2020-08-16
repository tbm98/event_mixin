import 'package:flutter/material.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';

import '../event_mixin.dart';

class EventListener extends StreamListener<EventBase> {
  const EventListener({
    Key key,
    @required Stream<EventBase> events,
    @required StreamOnDataListener<EventBase> onEvent,
    @required Widget child,
    StreamOnErrorListener onError,
    StreamOnDoneListener onDone,
    bool cancelOnError,
  }) : super(
          key: key,
          stream: events,
          onData: onEvent,
          child: child,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
}
