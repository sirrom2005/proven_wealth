import 'dart:ui';

class ChartData{
  final int index;
  final String title;
  final Color color;
  final double chartValue;
  final String chartTitle;

  ChartData({
    required this.index,
    required this.title,
    required this.color,
    required this.chartValue,
    required this.chartTitle
  });
}