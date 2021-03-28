
import 'package:flutter/material.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LauncherSettingsModel>(
      builder: (context, launcherSettingsModel, child) {
        return ListView(
          children: [
            Slider(
              value: launcherSettingsModel.iconSize,
              label: launcherSettingsModel.iconSize.toString(),
              onChanged: (iconSize) => launcherSettingsModel.setIconSize(iconSize),
              min: 16,
              max: 128,
              divisions: 14,
            ),
            Slider(
              value: launcherSettingsModel.itemSpacing,
              label: launcherSettingsModel.itemSpacing.toString(),
              onChanged: (itemSpacing) => launcherSettingsModel.setItemSpacing(itemSpacing),
              min: 0,
              max: 128,
              divisions: 16,
            ),
            Slider(
              value: launcherSettingsModel.itemPadding,
              label: launcherSettingsModel.itemPadding.toString(),
              onChanged: (itemPadding) => launcherSettingsModel.setItemPadding(itemPadding),
              min: 0,
              max: 128,
              divisions: 16,
            ),
            Slider(
              value: launcherSettingsModel.gridColumns.toDouble(),
              label: launcherSettingsModel.gridColumns.toString(),
              onChanged: (gridColumns) => launcherSettingsModel.setGridColumns(gridColumns.toInt()),
              min: 1,
              max: 10,
              divisions: 9,
            ),
            Slider(
              value: launcherSettingsModel.listColumns.toDouble(),
              label: launcherSettingsModel.listColumns.toString(),
              onChanged: (listColumns) => launcherSettingsModel.setListColumns(listColumns.toInt()),
              min: 1,
              max: 10,
              divisions: 9,
            ),
          ],
        );
      },
    );
  }
}
