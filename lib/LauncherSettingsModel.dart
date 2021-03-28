import 'package:flutter/material.dart';

class LauncherSettingsModel extends ChangeNotifier {
  double _iconSize = 32;
  double _itemSpacing = 8;
  double _itemPadding = 8;
  int _gridColumns = 6;
  int _listColumns = 3;

  double get iconSize => _iconSize;
  double get itemSpacing => _itemSpacing;
  double get itemPadding => _itemPadding;
  int get gridColumns => _gridColumns;
  int get listColumns => _listColumns;

  void setIconSize(double iconSize) {
    _iconSize = iconSize;
    notifyListeners();
  }

  void setItemSpacing(double itemSpacing) {
    _itemSpacing = itemSpacing;
    notifyListeners();
  }

  void setItemPadding(double itemPadding) {
    _itemPadding = itemPadding;
    notifyListeners();
  }

  void setGridColumns(int gridColumns) {
    _gridColumns = gridColumns;
    notifyListeners();
  }

  void setListColumns(int listColumns) {
    _listColumns = listColumns;
    notifyListeners();
  }
}
