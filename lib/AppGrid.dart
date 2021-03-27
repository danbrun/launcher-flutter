import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class AppGrid extends StatelessWidget {
  const AppGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceAppsModel, LauncherSettingsModel>(
      builder: (context, deviceAppsModel, launcherSettingsModel, child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: launcherSettingsModel.gridColumns,
            mainAxisSpacing: launcherSettingsModel.itemSpacing.toDouble(),
            crossAxisSpacing: launcherSettingsModel.itemSpacing.toDouble(),
          ),
          itemBuilder: (context, index) => AppGridItem(
            deviceAppsModel.apps[index],
            deviceAppsModel.icons[index],
            launcherSettingsModel.iconSize,
          ),
          itemCount: deviceAppsModel.apps.length,
          padding: MediaQuery.of(context).viewPadding + EdgeInsets.only(bottom: 16),
        );
      },
    );
  }
}

class AppGridItem extends StatelessWidget {
  final Application _app;
  final MemoryImage _icon;
  final int _iconSize;

  AppGridItem(this._app, this._icon, this._iconSize);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _app.openApp(),
      child: Image(
        image: _icon,
        width: _iconSize.toDouble(),
        height: _iconSize.toDouble(),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        alignment: Alignment.center,
        padding: MaterialStateProperty.all(EdgeInsets.all(16)),
      ),
    );
  }
}
