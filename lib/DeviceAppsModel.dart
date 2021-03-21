import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class DeviceAppsModel extends ChangeNotifier {
  List<Application> _apps = [];
  List<MemoryImage> _icons = [];

  DeviceAppsModel() {
    _update();
  }

  List<Application> get apps => _apps;
  List<MemoryImage> get icons => _icons;

  void _update() {
    DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    ).then((apps) => _setApps(apps));
  }

  void _setApps(List<Application> apps) {
    apps.sort((a, b) => a.appName.toUpperCase().compareTo(b.appName.toUpperCase()));
    _apps = apps;
    _icons = _apps.map((e) => MemoryImage((e as ApplicationWithIcon).icon)).toList();
    notifyListeners();
  }
}
