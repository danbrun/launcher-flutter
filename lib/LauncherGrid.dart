import 'package:flutter/material.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class LauncherGrid extends StatelessWidget {
  const LauncherGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceAppsModel, LauncherSettingsModel>(
      builder: (context, deviceAppsModel, launcherSettingsModel, child) {
        double itemWidth = MediaQuery.of(context).size.width / launcherSettingsModel.listColumns;
        double itemHeight = launcherSettingsModel.iconSize + 2 * launcherSettingsModel.itemPadding;
        if (!launcherSettingsModel.rightLabels) {
          itemHeight += launcherSettingsModel.fontSize + launcherSettingsModel.itemPadding;
        }

        return GridView.builder(
          itemBuilder: (builder, index) => LauncherItem(deviceAppsModel.apps[index]),
          itemCount: deviceAppsModel.apps.length,
          padding: MediaQuery.of(context).viewPadding + EdgeInsets.only(bottom: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: launcherSettingsModel.listColumns,
            childAspectRatio: itemWidth / itemHeight,
          ),
        );
      },
    );
  }
}

class LauncherItem extends StatelessWidget {
  final LauncherApplication _app;

  LauncherItem(this._app);

  @override
  Widget build(BuildContext context) {
    return Consumer<LauncherSettingsModel>(
      builder: (context, launcherSettingsModel, child) {
        EdgeInsets iconPadding = launcherSettingsModel.rightLabels
          ? EdgeInsets.only(right: launcherSettingsModel.itemPadding)
          : EdgeInsets.only(bottom: launcherSettingsModel.itemPadding);

        List<Widget> children = [
          Padding(
            child: Image(
              image: _app.icon,
              width: launcherSettingsModel.iconSize,
              height: launcherSettingsModel.iconSize,
            ),
            padding: iconPadding,
          ),
          Flexible(
            child: Text(
              _app.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: launcherSettingsModel.fontSize.toDouble(),
              ),
              textAlign: launcherSettingsModel.rightLabels ? TextAlign.left : TextAlign.center,
            ),
          ),
        ];

        return InkWell(
          onTap: () => _app.openApp(),
          onDoubleTap: () => _app.openSettings(),
          child: Padding(
            child: launcherSettingsModel.rightLabels ? Row(children: children) : Column(children: children),
            padding: EdgeInsets.all(launcherSettingsModel.itemPadding),
          ),
        );
      }
    );
  }
}
