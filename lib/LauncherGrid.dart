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
        return InkWell(
          onTap: () => _app.openApp(),
          onDoubleTap: () => _app.openSettings(),
          child: Padding(
            child: Row(
              children: [
                Padding(
                  child: Image(
                    image: _app.icon,
                    width: launcherSettingsModel.iconSize,
                    height: launcherSettingsModel.iconSize,
                  ),
                  padding: EdgeInsets.only(right: launcherSettingsModel.itemPadding),
                ),
                Flexible(
                  child: Text(
                    _app.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(launcherSettingsModel.itemPadding),
          ),
        );
      }
    );
  }
}
