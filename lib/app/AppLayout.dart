
import 'package:flutter/cupertino.dart';

class AppLayout {
  final int iconSize;
  final int labelSize;
  final Color labelColor;
  final AppLabelType labelType;
  final int columns;
  final int padding;

  const AppLayout({
    required this.iconSize,
    required this.labelSize,
    required this.labelColor,
    required this.labelType,
    required this.columns,
    required this.padding,
  });

  double getItemAspectRatio(double gridWidth) {
    return gridWidth / ((iconSize + 2 * padding) * columns);
  }
}

enum AppLabelType {
  right,
  below,
  none,
}
