import 'dart:math';

import 'package:flutter/material.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class AppList extends StatelessWidget {
  const AppList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceAppsModel, LauncherSettingsModel>(
      builder: (context, deviceAppsModel, launcherSettingsModel, child) {
        int appCount = deviceAppsModel.apps.length;
        int columnCount = launcherSettingsModel.listColumns;
        int rowCount = (appCount / columnCount).ceil();

        return ListView.separated(
          itemBuilder: (context, index) {
            int start = index * columnCount;
            int end = min(start + columnCount, appCount);

            return AppListRow(
              deviceAppsModel.apps.sublist(start, end),
              launcherSettingsModel.iconSize,
              launcherSettingsModel.listColumns,
              launcherSettingsModel.itemPadding,
            );
          },
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
  final List<LauncherApplication> _apps;
  final int _iconSize;
  final int _listColumns;
  final int _itemPadding;

  AppListRow(this._apps, this._iconSize, this._listColumns, this._itemPadding);

  @override
  Widget build(BuildContext context) {
    List<Widget> appListItems = [];

    for (int index = 0; index < _apps.length; index++) {
      appListItems.add(
        Expanded(
          child: AppListItem(_apps[index], _iconSize, _itemPadding)
        ),
      );
    }

    while (appListItems.length < _listColumns) {
      appListItems.add(
        Expanded(
          child: Container(),
        ),
      );
    }

    return Row(
      children: appListItems,
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
