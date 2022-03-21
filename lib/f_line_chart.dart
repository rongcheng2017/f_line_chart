library f_line_chart;

import 'package:f_line_chart/line_painter.dart';
import 'package:flutter/material.dart';

import 'line_chart_point.dart';

///
/// 1. 获取widget宽 计算x轴上的刻度
/// 2. 获取widget高 计算y轴  (maxHeight-minHeight)/xLineNums

class LineChart extends StatefulWidget {
  final Color bgColor;
  final Size size;
  final Color xAxisColor;
  final double xAxisWidth;
  final Color yAxisColor;
  final double yAxisWidth;
  //是否绘制y轴
  final bool drawYAxis;
  // x轴条数 最上面的一条是整个chart的顶部
  final int xLineNums;
  final List<LineChartPoint> points;

  final Color lineColor;
  final double lineWidth;
  final bool showXLineText;
  final Color xLineTextColor;

  const LineChart({
    Key? key,
    this.bgColor = const Color(0xFFF7F8FA),
    this.size = Size.infinite,
    this.xAxisColor = const Color(0xFFE2E4EA),
    this.xAxisWidth = 1,
    this.yAxisColor = const Color(0xFFE2E4EA),
    this.yAxisWidth = 1,
    this.drawYAxis = false,
    this.xLineNums = 1,
    this.lineColor = const Color(0xFF1678FF),
    this.lineWidth = 1,
    this.showXLineText = false,
    this.xLineTextColor = const Color(0xFF858B9C),
    required this.points,
  }) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: LinePainter(
        points: widget.points,
        bgColor: widget.bgColor,
        xAxisColor: widget.xAxisColor,
        xAxisWidth: widget.xAxisWidth,
        yAxisColor: widget.yAxisColor,
        yAxisWidth: widget.yAxisWidth,
        drawYAxis: widget.drawYAxis,
        xLineNums: widget.xLineNums,
        lineColor: widget.lineColor,
        lineWidth: widget.lineWidth,
        showXLineText: widget.showXLineText,
        xLineTextColor: widget.xLineTextColor,
      ),
    );
  }
}
