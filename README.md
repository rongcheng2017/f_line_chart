

## 效果展示

1. 基础效果

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a623f8f4ca364b93b5c3f7b999a31cb9~tplv-k3u1fbpfcp-watermark.image?)

2. 显示节点的效果

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c018824b73d745f4be6845c9307c9eeb~tplv-k3u1fbpfcp-watermark.image?)

3. 显示选中的效果
  
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/764edb676cb648b18fb393b02a11453c~tplv-k3u1fbpfcp-watermark.image?)

4. 显示y轴数据
  
![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7f24d66433cf488fb15156f94d929ed6~tplv-k3u1fbpfcp-watermark.image?)  

5. 多折线版本
  
![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ed4d164d1dcf47e6890828abd9c39aa3~tplv-k3u1fbpfcp-watermark.image?)

## 入门
以下是常用属性：
```dart
class LineChart extends StatefulWidget {
   //数据
  final List<LineChartPoint>? points;
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
  //多条折线的颜色
  final List<Color>? multipleLinePointsColor;
  //自定义x轴下方的标记文案，如果传入该数据，points中的marks失效。
  final List<String>? xLineMarks;

  ...
}

```

## 使用介绍

### 基础使用方法

> 下面是最简单的使用demo
```dart
class LineChartPage extends StatelessWidget {
  const LineChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("f_line_chart"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: LineChart(
            size: const Size(300, 200),
            //水平方向线条个数
            xLineNums: 6,
            points: _mockData(),
            //是否显示x轴下面的文案
            showXLineText: true,
          ),
        ),
      ),
    );
  }

  List<LineChartPoint> _mockData() {
    var res = <LineChartPoint>[];
    res.add(LineChartPoint(xStr: "01", xValue: 1, yStr: "100", yValue: 200));
    res.add(LineChartPoint(xStr: "02", xValue: 2, yStr: "200", yValue: 120));
    res.add(LineChartPoint(xStr: "03", xValue: 3, yStr: "300", yValue: 150));
    res.add(LineChartPoint(xStr: "04", xValue: 4, yStr: "400", yValue: 100));
    res.add(LineChartPoint(xStr: "05", xValue: 5, yStr: "400", yValue: 210));
    res.add(LineChartPoint(xStr: "06", xValue: 6, yStr: "400", yValue: 50));
    res.add(LineChartPoint(xStr: "07", xValue: 7, yStr: "300", yValue: 150));
    res.add(LineChartPoint(xStr: "08", xValue: 8, yStr: "400", yValue: 230));
    res.add(LineChartPoint(xStr: "09", xValue: 9, yStr: "400", yValue: 105));
    res.add(LineChartPoint(xStr: "10", xValue: 10, yStr: "400", yValue: 149));
    return res;
  }
}
```
**运行效果如下**：

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a623f8f4ca364b93b5c3f7b999a31cb9~tplv-k3u1fbpfcp-watermark.image?)


### LineChartPointConfig
> 通过配置LineChartPointConfig来设置是否要显示节点，以及节点的颜色、大小等属性。
```dart
import 'package:flutter/material.dart';

///折线图节点的配置
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


```
简单使用如下
```dart
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: LineChart(
            bgColor: const Color(0xFFF7F8FA),
            size: const Size(300, 200),
            xLineNums: 6,
            points: _mockData(),
            showXLineText: true,
            config: LineChartPointConfig(
                showNormalPoints: true,
                ),
          ),
        ),
      ),
```

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c018824b73d745f4be6845c9307c9eeb~tplv-k3u1fbpfcp-watermark.image?)



设置选中竖线和选中圆环
```dart
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: LineChart(
            bgColor: const Color(0xFFF7F8FA),
            size: const Size(300, 200),
            xLineNums: 6,
            points: _mockData(),
            showXLineText: true,
            config: LineChartPointConfig(
                showNormalPoints: true,
                showSelectedLine: true,
                showSelectedPoint: true),
          ),
        ),
      ),
```


![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/764edb676cb648b18fb393b02a11453c~tplv-k3u1fbpfcp-watermark.image?)

显示Y轴以及显示y轴上的单元数据。
```dart
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: LineChart(
            // bgColor: Color.fromARGB(255, 179, 216, 94),
            size: const Size(300, 200),
            xLineNums: 6,
            points: _mockData1(),
            showXLineText: true,
            //显示y轴
            showYAxis: true,
            //显示y轴上的标记文案
            showYLineMark: true,
            config: LineChartPointConfig(
                showNormalPoints: true,
                showSelectedLine: true,
                showSelectedPoint: true),
          ),
```

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7f24d66433cf488fb15156f94d929ed6~tplv-k3u1fbpfcp-watermark.image?)


设置节点选中回调:

```dart
LineChart(
          ...
            selectedCallback: (offset, point) {
              debugPrint(
                  " selectedCallback offset : x ${offset.dx}  y ${offset.dy}  point ${point.xStr}");
            },
            ...
          ),
```

显示多条折线

> 通过`multipleLinePoints`设置多条折线的数据和`multipleLinePointsColor`设置颜色。
```dart
class LineChartPage extends StatefulWidget {
  const LineChartPage({Key? key}) : super(key: key);

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("f_line_chart"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: LineChart(
            // bgColor: Color.fromARGB(255, 179, 216, 94),
            size: const Size(300, 200),
            xLineNums: 6,
            multipleLinePoints: _mockData1(),
            multipleLinePointsColor: const [
              Color(0xFFFF9E3D),
              Color(0xFF006BFF),
              Color(0xFF24A69B),
            ],
            showXLineText: true,
            showYAxis: false,
            showYLineMark: false,
            selectedCallback: (Offset offset, List<LineChartPoint>? points) {
              //如果points==null则代表没选中
              debugPrint(
                  " selectedCallback offset : x ${offset.dx}  y ${offset.dy} ");
              for (var element in points) {
                debugPrint(
                    "selected points :${element.xValue} ${element.yValue}");
              }
            },
            config: LineChartPointConfig(
                showNormalPoints: true,
                showSelectedLine: true,
                showSelectedPoint: true),
          ),
        ),
      ),
    );
  }



  List<List<LineChartPoint>> _mockData1() {
    var res = <LineChartPoint>[];
    res.add(LineChartPoint(xStr: "01", xValue: 1, yStr: "100", yValue: 102));
    res.add(LineChartPoint(xStr: "02", xValue: 2, yStr: "200", yValue: 130));
    res.add(LineChartPoint(xStr: "03", xValue: 3, yStr: "300", yValue: 110));
    res.add(LineChartPoint(xStr: "04", xValue: 4, yStr: "400", yValue: 120));
    res.add(LineChartPoint(xStr: "05", xValue: 5, yStr: "400", yValue: 170));
    res.add(LineChartPoint(xStr: "06", xValue: 6, yStr: "400", yValue: 110));
    res.add(LineChartPoint(xStr: "07", xValue: 7, yStr: "300", yValue: 130));
    res.add(LineChartPoint(xStr: "08", xValue: 8, yStr: "400", yValue: 234));
    res.add(LineChartPoint(xStr: "09", xValue: 9, yStr: "400", yValue: 110));
    res.add(LineChartPoint(xStr: "10", xValue: 10, yStr: "400", yValue: 140));
    var res1 = <LineChartPoint>[];
    res1.add(LineChartPoint(xStr: "01", xValue: 1, yStr: "100", yValue: 110));
    res1.add(LineChartPoint(xStr: "02", xValue: 2, yStr: "200", yValue: 140));
    res1.add(LineChartPoint(xStr: "03", xValue: 3, yStr: "300", yValue: 120));
    res1.add(LineChartPoint(xStr: "04", xValue: 4, yStr: "400", yValue: 100));
    res1.add(LineChartPoint(xStr: "05", xValue: 5, yStr: "400", yValue: 160));
    res1.add(LineChartPoint(xStr: "06", xValue: 6, yStr: "400", yValue: 100));
    res1.add(LineChartPoint(xStr: "07", xValue: 7, yStr: "300", yValue: 120));
    res1.add(LineChartPoint(xStr: "08", xValue: 8, yStr: "400", yValue: 210));
    res1.add(LineChartPoint(xStr: "09", xValue: 9, yStr: "400", yValue: 70));
    res1.add(LineChartPoint(xStr: "10", xValue: 10, yStr: "400", yValue: 80));
    var res2 = <LineChartPoint>[];
    res2.add(LineChartPoint(xStr: "01", xValue: 1, yStr: "100", yValue: 140));
    res2.add(LineChartPoint(xStr: "02", xValue: 2, yStr: "200", yValue: 160));
    res2.add(LineChartPoint(xStr: "03", xValue: 3, yStr: "300", yValue: 110));
    res2.add(LineChartPoint(xStr: "04", xValue: 4, yStr: "400", yValue: 100));
    res2.add(LineChartPoint(xStr: "05", xValue: 5, yStr: "400", yValue: 160));
    res2.add(LineChartPoint(xStr: "06", xValue: 6, yStr: "400", yValue: 80));
    res2.add(LineChartPoint(xStr: "07", xValue: 7, yStr: "300", yValue: 100));
    res2.add(LineChartPoint(xStr: "08", xValue: 8, yStr: "400", yValue: 150));
    res2.add(LineChartPoint(xStr: "09", xValue: 9, yStr: "400", yValue: 60));
    res2.add(LineChartPoint(xStr: "10", xValue: 10, yStr: "400", yValue: 80));
    var mutil = [res, res1, res2];
    return mutil;
  }
```
效果如下：

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ed4d164d1dcf47e6890828abd9c39aa3~tplv-k3u1fbpfcp-watermark.image?)

## Additional information

掘金文档： https://juejin.cn/post/7078496478750048263
