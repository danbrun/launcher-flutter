import 'dart:math';

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
        int appCount = deviceAppsModel.apps.length;
        int columnCount = launcherSettingsModel.listColumns;
        int rowCount = (appCount / columnCount).ceil();

        return ListView.separated(
          itemBuilder: (context, index) => AppListRow(
            deviceAppsModel.apps.sublist(index * columnCount, min((index + 1)* columnCount, appCount)),
            launcherSettingsModel.iconSize,
            launcherSettingsModel.listColumns,
            launcherSettingsModel.itemPadding,
          ),
          itemCount: rowCount,
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
  final List<Application> _apps;
  final int _iconSize;
  final int _listColumns;
  final int _itemPadding;

  AppListRow(this._apps, this._iconSize, this._listColumns, this._itemPadding);

  @override
  Widget build(BuildContext context) {
    List<Widget> appListItems = this._apps.map((app) => Expanded(
      child: AppListItem(
        app,
        _iconSize,
        _itemPadding,
      )
    )).toList();

    while (appListItems.length < _listColumns) {
      appListItems.add(Expanded(child: Container()));
    }

    return Row(
      children: appListItems,
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
          Flexible(
            child: Text(
              _app.appName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
