import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppInfo.dart';

class AppModel extends ChangeNotifier {
  static final String _pinnedPackagesTag = 'pinned_packages';
  static final String _hiddenPackagesTag = 'hidden_packages';

  final List<AppInfo> _appInfoList = [];
  final Set<String> _pinnedPackages = {};
  final Set<String> _hiddenPackages = {};

  SharedPreferences? _preferences;

  AppModel() {
    _setup();
    _refresh();
    _listen();
  }

  bool isPinned(AppInfo appInfo) => _pinnedPackages.contains(appInfo.package);
  bool isHidden(AppInfo appInfo) => _hiddenPackages.contains(appInfo.package);
  bool isUnpinned(AppInfo appInfo) => !isUnpinned(appInfo);
  bool isVisible(AppInfo appInfo) => !isHidden(appInfo);

  List<AppInfo> getPinned() => _appInfoList.where(isPinned).toList();
  List<AppInfo> getHidden() => _appInfoList.where(isHidden).toList();
  List<AppInfo> getUnpinned() => _appInfoList.where(isUnpinned).toList();
  List<AppInfo> getVisible() => _appInfoList.where(isVisible).toList();

  void togglePinned(AppInfo appInfo) => setPinned(appInfo, !isPinned(appInfo));
  void toggleHidden(AppInfo appInfo) => setHidden(appInfo, !isHidden(appInfo));

  void setPinned(AppInfo appInfo, bool isPinned) {
    if (isPinned) {
      _pinnedPackages.add(appInfo.package);
    } else {
      _pinnedPackages.remove(appInfo.package);
    }
    _preferences?.setStringList(_pinnedPackagesTag, _pinnedPackages.toList());
    notifyListeners();
  }

  void setHidden(AppInfo appInfo, bool isHidden) {
    if (isHidden) {
      _hiddenPackages.add(appInfo.package);
    } else {
      _hiddenPackages.remove(appInfo.package);
    }
    _preferences?.setStringList(_hiddenPackagesTag, _hiddenPackages.toList());
    notifyListeners();
  }

  void _setup() {
    SharedPreferences
      .getInstance()
      .then((preferences) {
        _preferences = preferences;
        _pinnedPackages.addAll(_preferences?.getStringList(_pinnedPackagesTag) ?? []);
        _hiddenPackages.addAll(_preferences?.getStringList(_hiddenPackagesTag) ?? []);
      });
  }

  void _refresh() {
    DeviceApps
      .getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true,
      )
      .then((applications) {
        _appInfoList.clear();
        _appInfoList.addAll(applications.map(_getAppInfo));
        _appInfoList.sort();
        notifyListeners();
      });
  }

  void _listen() {
    DeviceApps
      .listenToAppsChanges()
      .forEach((event) {
        _refresh();
      });
  }

  AppInfo _getAppInfo(Application application) {
    return AppInfo(
      name:  application.appName,
      package: application.packageName,
      icon: MemoryImage((application as ApplicationWithIcon).icon),
      openApp: application.openApp,
      openSettings: application.openSettingsScreen,
    );
  }
}
