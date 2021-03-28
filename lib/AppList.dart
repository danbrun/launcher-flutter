import 'package:flutter/material.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/FlexHeightGrid.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class AppList extends StatelessWidget {
  const AppList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceAppsModel, LauncherSettingsModel>(
      builder: (context, deviceAppsModel, launcherSettingsModel, child) {
        return FlexHeightGrid(
          itemBuilder: (builder, index) => AppListItem(
            deviceAppsModel.apps[index],
            launcherSettingsModel.iconSize,
            launcherSettingsModel.itemPadding,
          ),
          itemCount: deviceAppsModel.apps.length,
          columns: launcherSettingsModel.listColumns,
          spacing: launcherSettingsModel.itemSpacing.toDouble(),
          padding: MediaQuery.of(context).viewPadding + EdgeInsets.only(bottom: 16),
        );
      },
    );
  }
}

class AppListItem extends StatelessWidget {
  final LauncherApplication _app;
  final int _iconSize;
  final int _itemPadding;

  AppListItem(this._app, this._iconSize, this._itemPadding);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _app.openApp(),
      onDoubleTap: () => _app.openSettings(),
      child: Row(
        children: [
          Padding(
            child: Image(
              image: _app.icon,
              width: _iconSize.toDouble(),
              height: _iconSize.toDouble(),
            ),
            padding: EdgeInsets.all(_itemPadding.toDouble()),
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
    );
  }
}
