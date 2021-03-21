import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class AppList extends StatelessWidget {
  const AppList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceAppsModel, LauncherSettingsModel>(
      builder: (context, deviceAppsModel, launcherSettingsModel, child) {
        return ListView.separated(
          itemBuilder: (context, index) => AppListItem(
            deviceAppsModel.apps[index] as ApplicationWithIcon,
            launcherSettingsModel.iconSize,
            launcherSettingsModel.itemPadding
          ),
          itemCount: deviceAppsModel.apps.length,
          separatorBuilder: (context, index) => SizedBox(
            height: launcherSettingsModel.itemSpacing.toDouble()
          ),
          padding: MediaQuery.of(context).viewPadding + EdgeInsets.only(bottom: 16),
        );
      },
    );
  }
}

class AppListRow extends StatelessWidget {
  final ApplicationWithIcon _app;
  final int _iconSize;
  final int _itemPadding;

  AppListRow(this._app, this._iconSize, this._itemPadding);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

class AppListItem extends StatelessWidget {
  final ApplicationWithIcon _app;
  final int _iconSize;
  final int _itemPadding;

  AppListItem(this._app, this._iconSize, this._itemPadding);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _app.openApp(),
      child: Row(
        children: [
          Padding(
            child: Image.memory(
              _app.icon,
              width: _iconSize.toDouble(),
              height: _iconSize.toDouble(),
              alignment: Alignment.center,
            ),
            padding: EdgeInsets.all(_itemPadding.toDouble()),
          ),
          Text(_app.appName),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        alignment: Alignment.topLeft,
        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
      ),
    );
  }
}
