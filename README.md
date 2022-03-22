<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->



## Features
1.基础效果

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a623f8f4ca364b93b5c3f7b999a31cb9~tplv-k3u1fbpfcp-watermark.image?)


## Getting started
以下是常用属性：
```dart
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

  ...
}

```

## 使用介绍


下面是最简单的使用demo

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
            xLineNums: 6,
            points: _mockData(),
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
运行效果如下：
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a623f8f4ca364b93b5c3f7b999a31cb9~tplv-k3u1fbpfcp-watermark.image?)


## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
