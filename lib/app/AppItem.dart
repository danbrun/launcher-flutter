import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'AppInfo.dart';
import 'AppLayout.dart';
import 'AppSheet.dart';

class AppItem extends StatelessWidget {
  final AppLayout layout;
  final AppInfo appInfo;

  const AppItem({
    required this.layout,
    required this.appInfo,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget appItem;
    Widget icon = Image(
      image: appInfo.icon,
      width: layout.iconSize.toDouble(),
      height: layout.iconSize.toDouble(),
    );

    if (layout.labelType == AppLabelType.none) {
      appItem = Center(child: icon);
    } else {
      bool useRightLabel = layout.labelType == AppLabelType.right;

      List<Widget> children = [
        Padding(
          child: icon,
          padding: useRightLabel
            ? EdgeInsets.only(right: layout.padding.toDouble())
            : EdgeInsets.only(bottom: layout.padding.toDouble()),
        ),
        Flexible(
          child: Text(
            appInfo.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: layout.labelColor,
              fontSize: layout.labelSize.toDouble(),
            ),
            textAlign: useRightLabel
              ? TextAlign.left
              : TextAlign.center,
          ),
        ),
      ];

      appItem = useRightLabel
        ? Row(children: children)
        : Column(children: children);
    }

    return InkWell(
      onTap: () => appInfo.openApp(),
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => AppSheet(appInfo),
        );
      },
      child: Padding(
        child: appItem,
        padding: EdgeInsets.all(layout.padding.toDouble()),
      ),
    );
  }
}
