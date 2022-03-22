library f_line_chart;

import 'package:f_line_chart/line_chart_point_config.dart';
import 'package:f_line_chart/line_painter.dart';
import 'package:flutter/material.dart';

import 'line_chart_point.dart';

/// 1. 获取widget宽 计算x轴上的刻度
/// 2. 获取widget高 计算y轴  (maxHeight-minHeight)/xLineNums

class LineChart extends StatefulWidget {
  //数据
  final List<LineChartPoint> points;
  //折线图颜色
  final Color lineColor;
  //折线图宽度
  final double lineWidth;
  //背景色
  final Color bgColor;
  final Size size;
  //水平方向的线的颜色
  final Color xAxisColor;
  //水平方向的线的宽度
  final double xAxisWidth;
  //垂直方向的线的颜色
  final Color yAxisColor;
  //垂直方向的线的宽度
  final double yAxisWidth;
  //是否绘制y轴
  final bool drawYAxis;
  // x轴条数 最上面的一条是整个chart的顶部
  final int xLineNums;

  //是否显示x轴下方文字
  final bool showXLineText;
  //x轴下方文字颜色
  final Color xLineTextColor;

  ///折线图上点的设置
  final LineChartPointConfig? config;

  const LineChart({
    Key? key,
    required this.points,
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
    this.config,
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
        config: widget.config,
      ),
    );
  }
}
