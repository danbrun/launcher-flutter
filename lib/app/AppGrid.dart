import 'package:flutter/widgets.dart';

import 'AppInfo.dart';
import 'AppItem.dart';
import 'AppLayout.dart';

class AppGrid extends SliverLayoutBuilder {
  AppGrid({
    required AppLayout layout,
    required List<AppInfo> appInfoList,
    Key? key
  }) : super(
    key: key,
    builder: (context, sliverConstraints) {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => AppItem(
            layout: layout,
            appInfo: appInfoList[index],
          ),
          childCount: appInfoList.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: layout.columns,
          childAspectRatio: layout.getItemAspectRatio(MediaQuery.of(context).size.width),
        ),
      );
    },
  );
}
