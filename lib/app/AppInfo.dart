import 'package:flutter/painting.dart';

class AppInfo implements Comparable<AppInfo> {
  final String name;
  final String package;
  final MemoryImage icon;
  final Future<bool> Function() openApp;
  final Future<bool> Function() openSettings;

  const AppInfo({
    required this.name,
    required this.package,
    required this.icon,
    required this.openApp,
    required this.openSettings,
  });

  @override
  int compareTo(AppInfo other) {
    return name.toUpperCase().compareTo(other.name.toUpperCase());
  }
}
