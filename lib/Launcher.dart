import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:launcher/AppList.dart';
import 'package:launcher/Settings.dart';

class Launcher extends StatelessWidget {
  static const List<Widget> _tabViews = <Widget>[
    const AppList(),
    const Settings(),
  ];

  static const List<TabItem> _tabItems = <TabItem>[
    TabItem(
      icon: Icon(
        Icons.grid_view,
        color: Colors.white,
      ),
      title: 'Grid',
    ),
    TabItem(
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
      title: 'Settings',
    ),
  ];

  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabViews.length,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: TabBarView(
              children: _tabViews,
            ),
            bottomNavigationBar: ConvexAppBar(
              items: _tabItems,
              color: Colors.white,
              backgroundColor: Colors.grey[850],
              curveSize: 96,
              top: -16,
              style: TabStyle.react,
            ),
          );
        },
      )
    );
  }
}
