import 'package:flutter/material.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/Launcher.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Launcher',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DeviceAppsModel()),
          ChangeNotifierProvider(create: (context) => LauncherSettingsModel()),
        ],
        child: WillPopScope(
          child: Launcher(),
          onWillPop: () => Future.value(false),
        ),
      ),
    );
  }
}
