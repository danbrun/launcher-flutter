import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class DeviceAppsModel extends ChangeNotifier {
  static final List<ApplicationEventType> _removeEvents = [
    ApplicationEventType.disabled,
    ApplicationEventType.uninstalled,
    ApplicationEventType.updated,
  ];
  static final List<ApplicationEventType> _addEvents = [
    ApplicationEventType.enabled,
    ApplicationEventType.installed,
    ApplicationEventType.updated,
  ];
  final List<LauncherApplication> apps = [];

  DeviceAppsModel() {
    _setup();
    _listen();
  }

  void _setup() {
    DeviceApps
      .getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true,
      )
      .then(
        (apps) {
          _clear();
          _addAll(apps);
          _update();
        }
      );
  }

  void _listen() {
    DeviceApps
      .listenToAppsChanges()
      .listen((event) {
        if (_removeEvents.contains(event.event)) {
          _uninstall(event.packageName);
        }
        if (_addEvents.contains(event.event)) {
          _install(event.packageName);
        }
      });
  }

  void _clear() {
    apps.clear();
  }

  void _uninstall(String package) {
    apps.removeWhere((app) => app.package == package);
    _update();
  }

  void _install(String package) {
    DeviceApps
      .getApp(package, true)
      .then((app) {
        if (app != null) {
          _add(app);
          _update();
        }
      });
  }

  void _addAll(List<Application> apps) {
    apps.where((app) => app.enabled).forEach(_add);
  }

  void _add(Application app) {
    apps.add(LauncherApplication(app as ApplicationWithIcon));
  }

  void _update() {
    apps.sort();
    notifyListeners();
  }
}

class LauncherApplication implements Comparable<LauncherApplication> {
  final String name;
  final String package;
  final MemoryImage icon;
  final Future<bool> Function() openApp;
  final Future<bool> Function() openSettings;

  LauncherApplication(ApplicationWithIcon app)
    : name = app.appName,
      package = app.packageName,
      icon = MemoryImage(app.icon),
      openApp = app.openApp,
      openSettings = app.openSettingsScreen;

  @override
  int compareTo(LauncherApplication other) {
    return name.toUpperCase().compareTo(other.name.toUpperCase());
  }
}
