import 'package:flutter/material.dart';

class LauncherSettingsModel extends ChangeNotifier {
  double _iconSize = 32;
  double _itemPadding = 8;
  int _listColumns = 3;

  double get iconSize => _iconSize;
  double get itemPadding => _itemPadding;
  int get listColumns => _listColumns;

  void setIconSize(double iconSize) {
    _iconSize = iconSize;
    notifyListeners();
  }

  void setItemPadding(double itemPadding) {
    _itemPadding = itemPadding;
    notifyListeners();
  }

  void setListColumns(int listColumns) {
    _listColumns = listColumns;
    notifyListeners();
  }
}
