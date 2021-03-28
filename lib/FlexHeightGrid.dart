import 'package:flutter/material.dart';

class FlexHeightGrid extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final int columns;
  final double spacing;
  final EdgeInsets? padding;

  const FlexHeightGrid({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.columns,
    this.spacing = 0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        List<Widget> items = [];

        for (int column = 0; column < columns; column++) {
          int gridIndex = index * columns + column;
          items.add(
            Expanded(
              child: Padding(
                child: gridIndex < itemCount ? itemBuilder(context, gridIndex) : Container(),
                padding: EdgeInsets.all(spacing / 2),
              ),
            ),
          );
        }

        return Row(children: items);
      },
      itemCount: (itemCount / columns).ceil(),
      padding: (padding != null ? padding! : EdgeInsets.zero) + EdgeInsets.all(spacing / 2),
    );
  }
}
