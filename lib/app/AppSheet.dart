import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'AppInfo.dart';
import 'AppModel.dart';

class AppSheet extends StatelessWidget {
  final AppInfo appInfo;

  const AppSheet(this.appInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppModel appModel = Provider.of<AppModel>(context, listen: false);
    bool isPinned = appModel.isPinned(appInfo);
    bool isHidden = appModel.isHidden(appInfo);

    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(appInfo.name),
          leading: Image(
            image: appInfo.icon,
            width: 24,
            height: 24,
          ),
        ),
        ListTile(
          title: Text(isPinned ? 'Unpin' : 'Pin'),
          leading: Icon(
            isPinned
              ? Icons.location_off
              : Icons.location_on,
          ),
          onTap: () {
            appModel.togglePinned(appInfo);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(isHidden ? 'Show' : 'Hide'),
          leading: Icon(
            isHidden
              ? Icons.visibility
              : Icons.visibility_off,
          ),
          onTap: () {
            appModel.toggleHidden(appInfo);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('App settings'),
          leading: Icon(Icons.settings),
          onTap: () {
            appInfo.openSettings();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
