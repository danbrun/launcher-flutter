
class AppLayout {
  final int iconSize;
  final int textSize;
  final int columns;
  final int padding;
  final AppLabel label;

  const AppLayout({
    required this.iconSize,
    required this.textSize,
    required this.columns,
    required this.padding,
    required this.label,
  });

  double getItemAspectRatio(double gridWidth) {
    return gridWidth / ((iconSize + 2 * padding) * columns);
  }
}

enum AppLabel {
  right,
  below,
  none,
}
