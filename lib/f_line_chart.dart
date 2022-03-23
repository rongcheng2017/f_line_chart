library f_line_chart;

import 'package:f_line_chart/line_chart_point_config.dart';
import 'package:f_line_chart/line_chart_painter.dart';
import 'package:flutter/material.dart';

import 'line_chart_point.dart';

typedef SelectedCallback = void Function(Offset offset, LineChartPoint point);

/// 具体实现在[LineChartPainter]
class LineChart extends StatefulWidget {
  //数据
  final List<LineChartPoint> points;
  //折线图颜色
  final Color lineColor;
  //折线图宽度
  final double lineWidth;
  //背景色
  final Color bgColor;
  //折线图大小
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
  final bool showYAxis;
  // x轴条数 最上面的一条是整个chart的顶部
  final int xLineNums;

  //是否显示x轴下方文字
  final bool showXLineText;
  //x轴下方文字颜色
  final Color xLineTextColor;

  ///折线图上点的设置
  final LineChartPointConfig? config;

  ///显示Y轴上的标记文案
  final bool showYLineMark;

  //节点选中时回调
  final SelectedCallback? selectedCallback;
  //多条折线
  final List<List<LineChartPoint>>? multipleLinePoints;

  const LineChart({
    Key? key,
    required this.points,
    this.bgColor = const Color(0xFFF7F8FA),
    this.size = Size.infinite,
    this.xAxisColor = const Color(0xFFE2E4EA),
    this.xAxisWidth = 1,
    this.yAxisColor = const Color(0xFFE2E4EA),
    this.yAxisWidth = 1,
    this.showYAxis = false,
    this.xLineNums = 1,
    this.lineColor = const Color(0xFF1678FF),
    this.lineWidth = 1,
    this.showXLineText = false,
    this.xLineTextColor = const Color(0xFF858B9C),
    this.config,
    this.showYLineMark = false,
    this.selectedCallback,
    this.multipleLinePoints,
  }) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  Offset? _touchOffset;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => setState(() {
        _touchOffset = Offset(event.localPosition.dx, event.localPosition.dy);
      }),
      onPointerMove: (event) => setState(() {
        _touchOffset = Offset(event.localPosition.dx, event.localPosition.dy);
      }),
      onPointerUp: (event) => setState(() {
        _touchOffset = null;
      }),
      child: CustomPaint(
        size: widget.size,
        painter: LineChartPainter(
          points: widget.points,
          bgColor: widget.bgColor,
          xAxisColor: widget.xAxisColor,
          xAxisWidth: widget.xAxisWidth,
          yAxisColor: widget.yAxisColor,
          yAxisWidth: widget.yAxisWidth,
          drawYAxis: widget.showYAxis,
          xLineNums: widget.xLineNums,
          lineColor: widget.lineColor,
          lineWidth: widget.lineWidth,
          showXLineText: widget.showXLineText,
          xLineTextColor: widget.xLineTextColor,
          config: widget.config,
          touchOffset: _touchOffset,
          showYLineMark: widget.showYLineMark,
          selectedCallback: widget.selectedCallback,
          multipleLinePoints: widget.multipleLinePoints,
        ),
      ),
    );
  }
}
