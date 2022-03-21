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


![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a623f8f4ca364b93b5c3f7b999a31cb9~tplv-k3u1fbpfcp-watermark.image?)
## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

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

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
