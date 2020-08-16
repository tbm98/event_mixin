import 'package:event_mixin/event_mixin.dart';

class ShowSnackbarEvent extends EventBase {
  ShowSnackbarEvent({this.content, this.success});

  final String content;
  final bool success;
}
