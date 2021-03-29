import 'package:flutter/material.dart';

class FlexHeightGrid extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final int columns;
  final EdgeInsets? padding;

  const FlexHeightGrid({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.columns,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int row) {
        List<Widget> items = [];

        for (int column = 0; column < columns; column++) {
          int item = row * columns + column;
          items.add(
            Expanded(
              child: item < itemCount
                ? itemBuilder(context, item)
                : Container(),
            ),
          );
        }

        return Row(
          children: items,
        );
      },
      itemCount: (itemCount / columns).ceil(),
      padding: padding,
    );
  }
}
