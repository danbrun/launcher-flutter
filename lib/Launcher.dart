import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:launcher/AppGrid.dart';
import 'package:launcher/AppList.dart';

class Launcher extends StatefulWidget {
  const Launcher({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LauncherState();
}

class LauncherState extends State<Launcher> {
  static const List<Widget> _tabs = <Widget>[
    AppGrid(),
    AppList(),
  ];

  int _index = 0;

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _tabs.elementAt(_index),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
            icon: Icon(
              Icons.grid_view,
              color: Colors.white,
            ),
            title: 'Grid',
          ),
          TabItem(
            icon: Icon(
              Icons.view_list,
              color: Colors.white,
            ),
            title: 'List',
          ),
        ],
        initialActiveIndex: 0,
        onTap: _onTap,
        style: TabStyle.react,
        color: Colors.white,
        backgroundColor: Colors.grey[850],
        top: -16,
        curveSize: 96,
      ),
    );
  }
}
