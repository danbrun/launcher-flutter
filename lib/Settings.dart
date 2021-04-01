
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
            Card(
              child: ListTile(
                title: Text('Icon size'),
                subtitle: Slider(
                  value: launcherSettingsModel.iconSize,
                  label: launcherSettingsModel.iconSize.toString(),
                  onChanged: (iconSize) => launcherSettingsModel.setIconSize(iconSize),
                  min: 16,
                  max: 128,
                  divisions: 14,
                ),
                isThreeLine: true,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Padding'),
                subtitle: Slider(
                  value: launcherSettingsModel.itemPadding,
                  label: launcherSettingsModel.itemPadding.toString(),
                  onChanged: (itemPadding) => launcherSettingsModel.setItemPadding(itemPadding),
                  min: 0,
                  max: 32,
                  divisions: 8,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Columns'),
                subtitle: Slider(
                  value: launcherSettingsModel.listColumns.toDouble(),
                  label: launcherSettingsModel.listColumns.toString(),
                  onChanged: (listColumns) => launcherSettingsModel.setListColumns(listColumns.toInt()),
                  min: 1,
                  max: 5,
                  divisions: 4,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Right Labels'),
                subtitle: Switch(
                  value: launcherSettingsModel.rightLabels,
                  onChanged: (rightLabels) => launcherSettingsModel.setRightLabels(rightLabels),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
