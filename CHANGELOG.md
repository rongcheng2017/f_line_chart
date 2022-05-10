## 0.0.1

* 折线图的基本版本

## 1.0.0

* 添加节点选中回调

* 动态计算Y轴单元坐标，以及Y轴标记

* 添加选中的竖线和选中节点

* 添加显示普通节点的方式，配置LineChartPointConfig

## 1.0.1

* 设置多条折线

## 1.0.2

* 更新文档

## 1.0.3

* fix bug : 在选择回调中不能调用setStatue()方法;

## 1.0.4

* 当手指离开折线图时，selectedCallback 返回points为null。

## 1.0.5

* 新增xLineMarks字段，用来自定义x轴下方标记文案。

## 1.0.6

* 新增当数据为空时也能显示背景，和x轴。

## 1.0.7

* multipleLinePoints可以传null或者不传

## 1.0.8

* fix issue3 :https://github.com/rongcheng2017/f_line_chart/issues/3


## 1.0.9

* fix issue4 :https://github.com/rongcheng2017/f_line_chart/issues/4  增加Y轴单位


## 1.1.0

* 使用 useUnifyYUnit: true 设置不同折线使用同一坐标系方法

## 1.1.1

* 提供LineChartController, 调用unSelceted()，方法来手动取消选中状态。在出现事件冲突时手动取消选中状态。
  
## 1.1.2

* fix bug :NaN