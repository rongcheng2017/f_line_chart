import 'package:flutter/material.dart';

///折线图节点的配置
class LineChartPointConfig {
  //普通节点的颜色
  final Color normalPonitColor;
  //普通节点的半径
  final double normalPointRadius;
  //选中节点的颜色
  final Color selectedPointColor;
  //选中节点的样式
  final double selectedPointRadius;
  //是否显示节点
  final bool showNormalPoints;
  //是否显示选中节点
  final bool showSelectedPoint;
  //选中时的垂直线的颜色
  final Color selectedLineColor;
  //选中时的垂直线的宽度
  final double selectedLineWidth;
  //显示选中时的垂直线
  final bool showSelectedLine;
  

  LineChartPointConfig({
    this.normalPonitColor = const Color(0xFF1678FF),
    this.selectedPointColor = const Color(0xFF1678FF),
    this.selectedLineColor = const Color(0xFFA6A6A6),
    this.showSelectedLine = false,
    this.selectedLineWidth = 1,
    this.normalPointRadius = 2,
    this.selectedPointRadius = 4,
    this.showNormalPoints = false,
    this.showSelectedPoint = false,
  });
}
