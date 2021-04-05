import 'package:flutter/material.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/Launcher.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DeviceAppsModel()),
        ChangeNotifierProvider(create: (context) => LauncherSettingsModel()),
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
