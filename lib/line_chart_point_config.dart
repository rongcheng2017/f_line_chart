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

  LineChartPointConfig({
    this.normalPonitColor = const Color(0xFF1678FF),
    this.selectedPointColor = const Color(0xFF1678FF),
    this.normalPointRadius = 2,
    this.selectedPointRadius = 4,
    this.showNormalPoints = false,
    this.showSelectedPoint = false,
  });
}
