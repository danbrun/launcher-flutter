import 'package:flutter/material.dart';
import 'package:launcher/app/AppModel.dart';
import 'package:provider/provider.dart';

import 'Launcher.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppModel()),
      ],
      child: MaterialApp(
        title: 'Launcher',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: WillPopScope(
          child: Launcher(),
          onWillPop: () => Future.value(false),
        ),
      ),
    );
  }
}
