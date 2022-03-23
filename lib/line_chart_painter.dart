import 'dart:math';

import 'package:f_line_chart/f_line_chart.dart';
import 'package:f_line_chart/line_chart_point.dart';
import 'package:f_line_chart/line_chart_point_config.dart';
import 'package:flutter/material.dart';

double _selectedX = -1000;

class LineChartPainter extends CustomPainter {
  final Color bgColor;
  //x轴颜色
  final Color xAxisColor;
  late Paint _bgRectPaint;

  //x轴画笔
  late Paint _xAxisPaint;
  //y轴画笔
  late Paint? _yAxisPaint;

  final double xAxisWidth;
  // x轴条数
  final int xLineNums;

  late Color? yAxisColor;
  late double? yAxisWidth;
  //是否绘制y轴
  final bool drawYAxis;

  final List<LineChartPoint> points;

  final Color lineColor;
  final double lineWidth;
  //是否显示x轴底下的文案
  final bool showXLineText;
  //x轴底下的文案高度
  final int textHeight = 13;
  late Color? xLineTextColor;

  final LineChartPointConfig? config;
  //触摸的点
  final Offset? touchOffset;
  //是否先Y轴的标记
  final bool showYLineMark;
  final double topPadding;
  final double startPadding;
  final double endPadding;
  final SelectedCallback? selectedCallback;
  LineChartPainter({
    required this.bgColor,
    required this.xAxisColor,
    required this.xAxisWidth,
    required this.points,
    this.lineColor = const Color(0xFF1678FF),
    this.xLineTextColor,
    this.lineWidth = 1,
    this.yAxisColor,
    this.yAxisWidth,
    this.drawYAxis = false,
    this.xLineNums = 1,
    this.showXLineText = false,
    this.config,
    this.touchOffset,
    this.showYLineMark = false,
    this.topPadding = 10,
    this.startPadding = 10,
    this.endPadding = 15,
    this.selectedCallback,
  }) {
    _bgRectPaint = Paint()..color = bgColor;
    _xAxisPaint = Paint()
      ..color = xAxisColor
      ..strokeWidth = xAxisWidth;
    xLineTextColor = xLineTextColor ?? xAxisColor;

    if (drawYAxis) {
      yAxisColor = yAxisColor ?? xAxisColor;
      yAxisWidth = yAxisWidth ?? xAxisWidth;
      _yAxisPaint = Paint()
        ..color = yAxisColor!
        ..strokeWidth = yAxisWidth!;
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    // draw background
    var bgRect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRect(bgRect, _bgRectPaint);

    double yLineMarkW = _drawYLineMarks(canvas, size);

    _drawXLines(canvas, size, yLineMarkW);

    _drawYline(canvas, size, yLineMarkW);

    var realPoints = _generatePonits(points, size, yLineMarkW);
    _drawPath(canvas, size, realPoints);

    _drawXLineText(canvas, size, realPoints);

    _drawPoints(canvas, size, realPoints, config);

    _drawSelectedYLine(canvas, size, touchOffset, realPoints, config);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawYline(Canvas canvas, Size size, double yLineMarkW) {
    if (drawYAxis) {
      canvas.drawLine(
          Offset(startPadding + yAxisWidth! / 2 + yLineMarkW, topPadding),
          Offset(
            startPadding + yAxisWidth! / 2 + yLineMarkW,
            size.height - (showXLineText ? textHeight : 0),
          ),
          _yAxisPaint!);
    }
  }

  void _drawXLines(Canvas canvas, Size size, double yLineW) {
    if (xLineNums == 1) {
      canvas.drawLine(
          Offset(startPadding + yLineW, size.height - xAxisWidth / 2),
          Offset(size.width - endPadding, size.height - xAxisWidth / 2),
          _xAxisPaint);
      return;
    }
    //计算x轴线的间距
    double xLineDuration = showXLineText
        ? (size.height - (xAxisWidth) * xLineNums - textHeight - topPadding) /
            (xLineNums - 1)
        : (size.height - (xAxisWidth) * xLineNums - topPadding) /
            (xLineNums - 1);
    double startY = xAxisWidth / 2 + topPadding;
    for (int i = 0; i < xLineNums; ++i) {
      canvas.drawLine(Offset(startPadding + yLineW, startY),
          Offset(size.width - endPadding, startY), _xAxisPaint);
      startY = startY + xLineDuration + xAxisWidth;
    }
  }

  //绘制触摸到屏幕上时画竖线
  void _drawSelectedYLine(
      Canvas canvas,
      Size size,
      Offset? offset,
      List<RealChartPoint> realPoints,
      LineChartPointConfig? lineChartPointConfig) {
    if (offset == null || lineChartPointConfig == null) {
      _selectedX = -1000;
      return;
    }

    if (offset.dx < 0 || offset.dx > (size.width - endPadding)) {
      return;
    }
    if (!lineChartPointConfig.showSelectedLine &&
        !lineChartPointConfig.showSelectedPoint) {
      return;
    }
    var points = realPoints.where((e) {
      return e.point.x + pointXWithDuraiton / 2 >= offset.dx &&
          e.point.x - pointXWithDuraiton / 2 <= offset.dx;
    });
    if (points.isEmpty) return;
    var selectedPoint = points.first;
    if (selectedPoint.point.x != _selectedX) {
      _selectedX = selectedPoint.point.x;
      //选中事件回调
      selectedCallback?.call(
          Offset(selectedPoint.point.x, selectedPoint.point.y),
          selectedPoint.lineChartPoint);
    }

    //绘制选中节点时的竖线
    if (lineChartPointConfig.showSelectedLine) {
      Paint linePaint = Paint()
        ..color = lineChartPointConfig.selectedLineColor
        ..strokeWidth = lineChartPointConfig.selectedLineWidth
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
          Offset(selectedPoint.point.x, topPadding),
          Offset(selectedPoint.point.x + lineChartPointConfig.selectedLineWidth,
              showXLineText ? size.height - textHeight : size.height),
          linePaint);
    }
    //绘制选中节点时的选中环
    if (lineChartPointConfig.showSelectedPoint) {
      Paint selectedPonitFillPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      Paint selectedPonitStrokePaint = Paint()
        ..color = lineChartPointConfig.selectedPointColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineChartPointConfig.selectedPointRadius -
            lineChartPointConfig.normalPointRadius;
      canvas.drawCircle(Offset(selectedPoint.point.x, selectedPoint.point.y),
          lineChartPointConfig.selectedPointRadius, selectedPonitStrokePaint);
      canvas.drawCircle(
          Offset(selectedPoint.point.x, selectedPoint.point.y),
          lineChartPointConfig.selectedPointRadius -
              lineChartPointConfig.normalPointRadius,
          selectedPonitFillPaint);
    }
  }

  double pointXWithDuraiton = 0.0;
  List<RealChartPoint> _generatePonits(
      List<LineChartPoint> points, Size size, double yLineMarkW) {
    List<RealChartPoint> realPoints = <RealChartPoint>[];

    LineChartPoint maxY =
        points.reduce((cur, next) => cur.yValue > next.yValue ? cur : next);
    LineChartPoint minY =
        points.reduce((cur, next) => cur.yValue < next.yValue ? cur : next);
    LineChartPoint maxX =
        points.reduce((cur, next) => cur.xValue > next.xValue ? cur : next);
    LineChartPoint minX =
        points.reduce((cur, next) => cur.xValue < next.xValue ? cur : next);

    points.reduce((cur, next) => cur.yValue < next.yValue ? cur : next);
    //向上扩大
    double max1 = (maxY.yValue / 10).ceil() * 10;
    //向下扩大
    double min1 = yLineStartN;
    //图表区的高度
    double yH = (size.height - topPadding - (showXLineText ? textHeight : 0));
    //竖直方向最小的宽度单位
    double yMinLineWidthDuration = yH / (max1 - min1);

    //计算xDuration
    var pointXValueDuration = (maxX.xValue - minX.xValue) / (points.length - 1);

    pointXWithDuraiton = (size.width - startPadding - endPadding - yLineMarkW) /
        (points.length - 1);

    for (var element in points) {
      var x = startPadding +
          yLineMarkW +
          ((element.xValue - minX.xValue) / pointXValueDuration) *
              pointXWithDuraiton;
      var valueH = (element.yValue - minY.yValue) * yMinLineWidthDuration;
      var y = topPadding +
          ((maxY.yValue - minY.yValue) * yMinLineWidthDuration -
              valueH +
              ((max1 - maxY.yValue) * yMinLineWidthDuration));
      Point<double> point = Point(x, y);
      realPoints.add(RealChartPoint(point, element));
    }

    return realPoints;
  }

  ///绘制折线图
  void _drawPath(Canvas canvas, Size size, List<RealChartPoint> realPoints) {
    var linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    var path = Path();
    var l = realPoints.length;
    for (var i = 0; i < l; i++) {
      var p = realPoints[i].point;
      if (i == 0) {
        path.moveTo(p.x, p.y);
      } else {
        path.lineTo(p.x, p.y);
      }
    }
    canvas.drawPath(path, linePaint);
  }

  ///绘制节点上的原点
  void _drawPoints(Canvas canvas, Size size, List<RealChartPoint> realPoints,
      LineChartPointConfig? config) {
    if (config?.showNormalPoints != true) return;
    Paint pointPaint = Paint()
      ..color = config!.normalPonitColor
      ..style = PaintingStyle.fill;
    for (var element in realPoints) {
      canvas.drawCircle(Offset(element.point.x, element.point.y),
          config.normalPointRadius, pointPaint);
    }
  }

  ///画x轴底下的文案
  void _drawXLineText(
      Canvas canvas, Size size, List<RealChartPoint> realPoints) {
    if (!showXLineText) return;
    for (var element in realPoints) {
      var textPainter = TextPainter(
        text: TextSpan(
            text: element.lineChartPoint.xStr,
            style: TextStyle(color: xLineTextColor, fontSize: 10)),
        textDirection: TextDirection.rtl,
        textWidthBasis: TextWidthBasis.longestLine,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(element.point.x - textPainter.width / 2,
            size.height - textPainter.height),
      );
    }
  }

  ///y轴方向最小单元距离
  double _getYLineWidthDuration(Size size, List<LineChartPoint> points) {
    LineChartPoint maxY =
        points.reduce((cur, next) => cur.yValue > next.yValue ? cur : next);
    LineChartPoint minY =
        points.reduce((cur, next) => cur.yValue < next.yValue ? cur : next);
    //向上扩大
    double max1 = (maxY.yValue / 10).ceil() * 10;
    //向下扩大
    double min1 = (minY.yValue / 10).floor() * 10;

    //y轴方向最小单元距离
    return (size.height - topPadding - (showXLineText ? textHeight : 0)) /
        (max1 - min1);
  }

  ///y轴最下面的竖直
  double yLineStartN = 0;

  ///画y轴上的标记，并返回标记文案所占的宽度
  double _drawYLineMarks(Canvas canvas, Size size) {
    LineChartPoint maxY =
        points.reduce((cur, next) => cur.yValue > next.yValue ? cur : next);
    LineChartPoint minY =
        points.reduce((cur, next) => cur.yValue < next.yValue ? cur : next);
    //向上扩大
    double max1 = (maxY.yValue / 10).ceil() * 10;
    //向下扩大
    double min1 = (minY.yValue / 10).floor() * 10;
    //所有标记中文案最宽的
    double maxYLineMarkTextW = 0.0;

    double duration = (max1 - min1) / (xLineNums - 1);
    if (minY.yValue > 10) {
      int a = duration ~/ 10;
      duration = (a + 1) * 10;
    }
    //y轴上每个单元间间距
    double yLineHeightDuration =
        (size.height - topPadding - (showXLineText ? textHeight : 0)) /
            (xLineNums - 1);
    yLineStartN = max1 - duration * (xLineNums - 1).toInt();

    if (!showYLineMark) return maxYLineMarkTextW;
    for (int i = 0; i < xLineNums; ++i) {
      //不绘制文案

      var textPainter = TextPainter(
        text: TextSpan(
          text: "${(max1 - duration * i).toInt()}",
          style: TextStyle(color: xLineTextColor, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.longestLine,
      )..layout();
      maxYLineMarkTextW = max(maxYLineMarkTextW, textPainter.width);
      textPainter.paint(
        canvas,
        Offset(startPadding - 1,
            topPadding + yLineHeightDuration * i - textPainter.height / 2),
      );
    }
    return maxYLineMarkTextW;
  }
}

class RealChartPoint {
  final Point<double> point;
  final LineChartPoint lineChartPoint;

  RealChartPoint(this.point, this.lineChartPoint);
}
