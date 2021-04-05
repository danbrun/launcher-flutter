import 'package:flutter/material.dart';
import 'package:launcher/DeviceAppsModel.dart';
import 'package:launcher/LauncherSettingsModel.dart';
import 'package:provider/provider.dart';

class LauncherGrid extends StatelessWidget {
  final List<LauncherApplication> Function(DeviceAppsModel) appFilter;

  const LauncherGrid({required this.appFilter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceAppsModel, LauncherSettingsModel>(
      builder: (context, deviceAppsModel, launcherSettingsModel, child) {
        double itemWidth = MediaQuery.of(context).size.width / launcherSettingsModel.listColumns;
        double itemHeight = launcherSettingsModel.iconSize + 2 * launcherSettingsModel.itemPadding;
        if (!launcherSettingsModel.rightLabels) {
          itemHeight += launcherSettingsModel.fontSize + launcherSettingsModel.itemPadding;
        }

        List<LauncherApplication> apps = appFilter(deviceAppsModel);

        return GridView.builder(
          itemBuilder: (builder, index) => LauncherItem(apps[index]),
          itemCount: apps.length,
          padding: MediaQuery.of(context).viewPadding + EdgeInsets.only(bottom: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: launcherSettingsModel.listColumns,
            childAspectRatio: itemWidth / itemHeight,
          ),
        );
      },
    );
  }
}

class LauncherItem extends StatelessWidget {
  final LauncherApplication app;

  const LauncherItem(this.app, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LauncherSettingsModel>(
      builder: (context, launcherSettingsModel, child) {
        EdgeInsets iconPadding = launcherSettingsModel.rightLabels
          ? EdgeInsets.only(right: launcherSettingsModel.itemPadding)
          : EdgeInsets.only(bottom: launcherSettingsModel.itemPadding);

        List<Widget> children = [
          Padding(
            child: Image(
              image: app.icon,
              width: launcherSettingsModel.iconSize,
              height: launcherSettingsModel.iconSize,
            ),
            padding: iconPadding,
          ),
          Flexible(
            child: Text(
              app.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: launcherSettingsModel.fontSize.toDouble(),
              ),
              textAlign: launcherSettingsModel.rightLabels ? TextAlign.left : TextAlign.center,
            ),
          ),
        ];

        return InkWell(
          onTap: () => app.openApp(),
          onLongPress: () => showModalBottomSheet(context: context, builder: (context) => LauncherSheet(app)),
          child: Padding(
            child: launcherSettingsModel.rightLabels ? Row(children: children) : Column(children: children),
            padding: EdgeInsets.all(launcherSettingsModel.itemPadding),
          ),
        );
      }
    );
  }
}

class LauncherSheet extends StatelessWidget {
  final LauncherApplication app;

  const LauncherSheet(this.app, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceAppsModel deviceAppsModel = Provider.of<DeviceAppsModel>(context, listen: false);
    bool isPinned = deviceAppsModel.isPinned(app);
    bool isHidden = deviceAppsModel.isHidden(app);

    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(app.name),
          leading: Image(
            image: app.icon,
            width: 24,
            height: 24,
          ),
        ),
        ListTile(
          title: Text(isPinned ? 'Unpin' : 'Pin'),
          leading: Icon(isPinned ? Icons.star_outline_rounded : Icons.star_rounded),
          onTap: () {
            deviceAppsModel.togglePinned(app);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(isHidden ? 'Show' : 'Hide'),
          leading: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            deviceAppsModel.toggleHidden(app);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('App settings'),
          leading: Icon(Icons.settings),
          onTap: () {
            app.openSettings();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
