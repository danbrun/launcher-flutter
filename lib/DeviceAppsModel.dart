import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class DeviceAppsModel extends ChangeNotifier {
  List<Application> _apps = [];

  List<Application> get apps => _apps;


  DeviceAppsModel() {
    _update();
  }

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
    notifyListeners();
  }
}
