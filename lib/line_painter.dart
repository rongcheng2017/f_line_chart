import 'dart:math';

import 'package:f_line_chart/line_chart_point.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LinePainter extends CustomPainter {
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

  LinePainter({
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
    // draw x line
    _drawXLines(canvas, size);
    // draw y line
    _drawYline(canvas, size);

    var realPoints = _generatePonits(points, size);
    drawPath(canvas, size, realPoints);
    if (showXLineText) _drawXLineText(canvas, size, realPoints);
    // drawText(canvas,size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }

  void _drawYline(Canvas canvas, Size size) {
    if (drawYAxis) {
      canvas.drawLine(Offset(yAxisWidth! / 2, 0),
          Offset(yAxisWidth! / 2, size.height), _yAxisPaint!);
    }
  }

  void _drawXLines(Canvas canvas, Size size) {
    if (xLineNums == 1) {
      canvas.drawLine(Offset(0, size.height - xAxisWidth / 2),
          Offset(size.width, size.height - xAxisWidth / 2), _xAxisPaint);
      return;
    }
    //计算x轴线的间距
    double xLineDuration = showXLineText
        ? (size.height - (xAxisWidth) * xLineNums - textHeight) /
            (xLineNums - 1)
        : (size.height - (xAxisWidth) * xLineNums) / (xLineNums - 1);
    double startY = xAxisWidth / 2;
    for (int i = 0; i < xLineNums; ++i) {
      canvas.drawLine(
          Offset(0, startY), Offset(size.width, startY), _xAxisPaint);
      startY = startY + xLineDuration + xAxisWidth;
    }
  }

  List<RealChartPoint> _generatePonits(List<LineChartPoint> points, Size size) {
    List<RealChartPoint> realPoints = <RealChartPoint>[];
    LineChartPoint maxY =
        points.reduce((cur, next) => cur.yValue > next.yValue ? cur : next);
    LineChartPoint minY =
        points.reduce((cur, next) => cur.yValue < next.yValue ? cur : next);
    LineChartPoint maxX =
        points.reduce((cur, next) => cur.xValue > next.xValue ? cur : next);
    LineChartPoint minX =
        points.reduce((cur, next) => cur.xValue < next.xValue ? cur : next);

    //计算xDuration
    var pointXValueDuration = (maxX.xValue - minX.xValue) / (points.length - 1);
    var pointXWithDuraiton = size.width / (points.length - 1);
    var pointYValueDuration = (maxY.yValue - minY.yValue) / (points.length - 1);
    //让整个图上下有点空隙 不然size.height / (points.length-1);
    var pointYWithDuraiton =
        (size.height - (showXLineText ? textHeight : 0)) / (points.length);

    for (var element in points) {
      Point<double> point = Point(
          (element.xValue - minX.xValue) /
              pointXValueDuration *
              pointXWithDuraiton,
          (element.yValue - minY.yValue + pointYWithDuraiton / 2) /
              pointYValueDuration *
              pointYWithDuraiton);
      realPoints.add(RealChartPoint(point, element));
    }

    return realPoints;
  }

  void drawText(Canvas canvas, Size size) {
    // 第一步
    final paragraphStyle = ui.ParagraphStyle(
        // 字体方向，有些国家语言是从右往左排版的
        textDirection: TextDirection.ltr,
        // 字体对齐方式
        textAlign: TextAlign.justify,
        fontSize: 10,
        maxLines: 1,
        // 字体超出大小时显示的提示
        ellipsis: '...',
        fontStyle: FontStyle.italic,
        // 当我们设置[TextStyle.height]时 这个高度是否应用到字体顶部和底部
        textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: true, applyHeightToLastDescent: true));
// 第二步 与第三步
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..addText('ParagraphBuilder');
// 第四步
    var paragraph = paragraphBuilder.build();
// 第五步
    paragraph.layout(const ui.ParagraphConstraints(width: 100));
// 画一个辅助矩形（可以通过paragraph.width和paragraph.height来获取绘制文字的宽高）
    // canvas.drawRect(
    //     Rect.fromLTRB(50, 50, 50 + paragraph.width, 50 + paragraph.height),
    //     _bgRectPaint);
// 第六步
    canvas.drawParagraph(paragraph, Offset(0, size.height - 15));
  }

  void drawPath(Canvas canvas, Size size, List<RealChartPoint> realPoints) {
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

  ///画x轴底下的文案
  void _drawXLineText(
      Canvas canvas, Size size, List<RealChartPoint> realPoints) {
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
        Offset(
            element.point.x >= size.width
                ? (element.point.x - textPainter.width)
                : element.point.x,
            size.height - textPainter.height),
      );
    }
  }
}

class RealChartPoint {
  final Point<double> point;
  final LineChartPoint lineChartPoint;

  RealChartPoint(this.point, this.lineChartPoint);
}
