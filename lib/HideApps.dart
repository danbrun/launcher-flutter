import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/app/AppInfo.dart';
import 'package:launcher/app/AppModel.dart';
import 'package:provider/provider.dart';

class HideApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hide apps'),
      ),
      body: Consumer<AppModel>(
        builder: (context, appModel, child) {
          List<AppInfo> appInfoList = appModel.getAll();

          return ListView.builder(
            itemBuilder: (context, index) {
              AppInfo appInfo = appInfoList[index];

              return SwitchListTile(
                title: Text(appInfo.name),
                secondary: Image(
                  image: appInfo.icon,
                  width: 24,
                  height: 24,
                ),
                value: appModel.isVisible(appInfo),
                onChanged: (isHidden) => appModel.setHidden(appInfo, !isHidden),
              );
            },
            itemCount: appInfoList.length,
          );
        },
      ),
    );
  }
}
