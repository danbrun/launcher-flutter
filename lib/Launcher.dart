import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:launcher/HideApps.dart';
import 'package:provider/provider.dart';

import 'app/AppGrid.dart';
import 'app/AppLayout.dart';
import 'app/AppModel.dart';

class Launcher extends StatelessWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppModel>(
        builder: (context, appModel, child) {
          AppLayout appLayout = AppLayout(
            iconSize: 32,
            labelSize: 12,
            labelColor: Colors.white,
            labelType: AppLabelType.right,
            columns: 3,
            padding: 8,
          );

          return CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: AppGrid(
                  layout: appLayout,
                  appInfoList: appModel.getVisible(),
                ),
                bottom: false,
              ),
              SliverSafeArea(
                sliver: SliverToBoxAdapter(
                  child: ListTile(
                    title: Text(
                      'Hide apps',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HideApps())
                    ),
                  ),
                ),
                top: false,
              ),
            ],
          );
        },
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
