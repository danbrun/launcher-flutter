import 'package:flutter/material.dart';

class LauncherSettingsModel extends ChangeNotifier {
  int _iconSize = 32;
  int _itemSpacing = 8;
  int _gridColumns = 6;
  int _itemPadding = 8;

  int get iconSize => _iconSize;
  int get itemSpacing => _itemSpacing;
  int get gridColumns => _gridColumns;
  int get itemPadding => _itemPadding;

  void setLauncherSettings(int iconSize, int itemSpacing, int gridColumns, int itemPadding) {
    _iconSize = iconSize;
    _itemSpacing = itemSpacing;
    _gridColumns = gridColumns;
    _itemPadding = itemPadding;
    notifyListeners();
  }
}
