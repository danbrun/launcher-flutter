import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static final String _hiddenPackagesTag = 'hidden_packages';
  static final String _pinnedPackagesTag = 'pinned_packages';

  final List<LauncherApplication> _apps = [];
  final List<String> _pinnedPackages = [];
  final List<String> _hiddenPackages = [];

  SharedPreferences? _preferences;

  DeviceAppsModel() {
    _setup();
    _listen();
  }

  bool isPinned(LauncherApplication app) => _pinnedPackages.contains(app.package);
  bool isUnpinned(LauncherApplication app) => !_pinnedPackages.contains(app.package);
  bool isHidden(LauncherApplication app) => _hiddenPackages.contains(app.package);
  bool isVisible(LauncherApplication app) => !_hiddenPackages.contains(app.package);

  List<LauncherApplication> getPinned() => _apps.where(isPinned).toList();
  List<LauncherApplication> getUnpinned() => _apps.where(isUnpinned).toList();
  List<LauncherApplication> getHidden() => _apps.where(isHidden).toList();
  List<LauncherApplication> getVisible() => _apps.where(isVisible).toList();

  void setPinned(LauncherApplication app, bool isPinned) {
    if (isPinned) {
      _pinnedPackages.add(app.package);
    } else {
      _pinnedPackages.remove(app.package);
    }
    _preferences?.setStringList(_pinnedPackagesTag, _pinnedPackages);
    notifyListeners();
  }

  void togglePinned(LauncherApplication app) {
    setPinned(app, !isPinned(app));
  }

  void setHidden(LauncherApplication app, bool isHidden) {
    if (isHidden) {
      _hiddenPackages.add(app.package);
    } else {
      _hiddenPackages.remove(app.package);
    }
    _preferences?.setStringList(_hiddenPackagesTag, _hiddenPackages);
    notifyListeners();
  }

  void toggleHidden(LauncherApplication app) {
    setHidden(app, !isHidden(app));
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

    SharedPreferences
      .getInstance()
      .then((preferences) {
        _preferences = preferences;
        _pinnedPackages.addAll(_preferences?.getStringList(_pinnedPackagesTag) ?? []);
        _hiddenPackages.addAll(_preferences?.getStringList(_hiddenPackagesTag) ?? []);
      });
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
    _apps.clear();
  }

  void _uninstall(String package) {
    _apps.removeWhere((app) => app.package == package);
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
    _apps.add(LauncherApplication(app as ApplicationWithIcon));
  }

  void _update() {
    _apps.sort();
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
