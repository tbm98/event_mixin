import 'package:event_mixin/event_mixin.dart';
import 'package:example/events/dismis_dialog_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import 'events/loading_event.dart';
import 'events/show_snackbar_event.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final stProvider = StateNotifierProvider((ref) => ST());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulHookWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class ST extends StateNotifier<int> with EventMixin {
  ST() : super(0);

  @override
  void dispose() {
    super.dispose();
    eventDispose();
  }

  void increA() async {
    state++;
    putEvent(LoadingEvent());
    await Future.delayed(Duration(seconds: 1));
    putEvent(DismisDialogEvent());
    state++;
    putEvent(ShowSnackbarEvent(content: 'content'));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: EventListener(
          events: useProvider(stProvider).events,
          onEvent: (event) => onData(event, context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(stProvider).increA();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  void onData(EventBase event, BuildContext context) {
    if (event is LoadingEvent) {
      showDialog(
          context: context,
          builder: (ct) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    }
    if (event is DismisDialogEvent) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    if (event is ShowSnackbarEvent) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(event.content),
      ));
    }
  }
}
