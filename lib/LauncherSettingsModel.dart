import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LauncherSettingsModel extends ChangeNotifier {
  double _iconSize = 32;
  double _itemPadding = 8;
  int _listColumns = 3;

  double get iconSize => _iconSize;
  double get itemPadding => _itemPadding;
  int get listColumns => _listColumns;

  SharedPreferences? _preferences;

  LauncherSettingsModel() {
    SharedPreferences
      .getInstance()
      .then((preferences) {
        _preferences = preferences;
        _iconSize = preferences.getDouble('iconSize') ?? _iconSize;
        _itemPadding = preferences.getDouble('itemPadding') ?? _itemPadding;
        _listColumns = preferences.getInt('listColumns') ?? _listColumns;
        notifyListeners();
      });
  }

  void setIconSize(double iconSize) {
    _iconSize = iconSize;
    _preferences?.setDouble('iconSize', _iconSize);
    notifyListeners();
  }

  void setItemPadding(double itemPadding) {
    _itemPadding = itemPadding;
    _preferences?.setDouble('itemPadding', _itemPadding);
    notifyListeners();
  }

  void setListColumns(int listColumns) {
    _listColumns = listColumns;
    _preferences?.setInt('listColumns', _listColumns);
    notifyListeners();
  }
}
