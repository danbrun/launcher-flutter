import 'package:flutter/material.dart';
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
  final LauncherApplication _app;
  final int _iconSize;

  AppGridItem(this._app, this._iconSize);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _app.openApp(),
      onDoubleTap: () => _app.openSettings(),
      child: Center(
        child: Image(
          image: _app.icon,
          width: _iconSize.toDouble(),
          height: _iconSize.toDouble(),
        ),
      ),
    );
  }
}
