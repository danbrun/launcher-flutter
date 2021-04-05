import 'package:flutter/material.dart';
import 'package:launcher/app/AppGrid.dart';
import 'package:launcher/app/AppLayout.dart';
import 'package:launcher/app/AppModel.dart';
import 'package:provider/provider.dart';

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

class Launcher extends StatelessWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: AppGrid(
                  layout: AppLayout(
                    iconSize: 32,
                    textSize: 12,
                    columns: 3,
                    padding: 8,
                    label: AppLabel.right,
                  ),
                  appInfoList: appModel.getVisible(),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
        );
      },
    );
  }
}
