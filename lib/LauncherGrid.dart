import 'package:flutter/material.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/FlexHeightGrid.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class LauncherGrid extends StatelessWidget {
  const LauncherGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceAppsModel, LauncherSettingsModel>(
      builder: (context, deviceAppsModel, launcherSettingsModel, child) {
        return FlexHeightGrid(
          itemBuilder: (builder, index) => LauncherItem(
            deviceAppsModel.apps[index],
            launcherSettingsModel.iconSize,
            launcherSettingsModel.itemPadding,
          ),
          itemCount: deviceAppsModel.apps.length,
          columns: launcherSettingsModel.listColumns,
          padding: MediaQuery.of(context).viewPadding + EdgeInsets.only(bottom: 16),
        );
      },
    );
  }
}

class LauncherItem extends StatelessWidget {
  final LauncherApplication _app;
  final double _iconSize;
  final double _itemPadding;

  LauncherItem(this._app, this._iconSize, this._itemPadding);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _app.openApp(),
      onDoubleTap: () => _app.openSettings(),
      child: Padding(
        child: Row(
          children: [
            Padding(
              child: Image(
                image: _app.icon,
                width: _iconSize,
                height: _iconSize,
              ),
              padding: EdgeInsets.only(right: _itemPadding),
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
        padding: EdgeInsets.all(_itemPadding),
      ),
    );
  }
}
