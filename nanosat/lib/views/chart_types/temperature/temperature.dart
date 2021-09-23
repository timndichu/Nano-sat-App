import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;

import 'dart:math' as math;
import 'package:path_provider/path_provider.dart';

/// Package import
import 'package:intl/intl.dart';
import 'package:nanosat/helper/helper.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/services.dart';
import 'package:nanosat/models/sensor_readings.dart';
import 'package:nanosat/providers/sensor_readings_provider.dart';
import 'package:nanosat/services/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class Temperature extends StatefulWidget {
  @override
  _TemperatureState createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  List<SensorReading> reading;
  bool isLoading = false;
  ChartSeriesController _chartSeriesController;
  Timer timer;
  @override
  void initState() {
     timer =
        Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
    super.initState();
  }

  List<LiveData> chartData = <LiveData>[];
  int count = 19;
  
    @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  LiveData singleData = LiveData(val: 32, x: 83);

  void _updateDataSource(Timer timer) {
   
      chartData.add(singleData);
      if (chartData.length == 20) {
        chartData.removeAt(0);
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData.length - 1],
          removedDataIndexes: <int>[0],
        );
      } else {
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData.length - 1],
        );
      }
      count = count + 1;
  
  }

  ///Get the random data
  int _getRandomInt(int min, int max) {
    final math.Random _random = math.Random();
    return min + _random.nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
     SfCartesianChart _buildLiveLineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData,
            color: const Color.fromRGBO(192, 108, 132, 1),
            xValueMapper: (LiveData readings, _) => readings.x,
            yValueMapper: (LiveData readings, _) =>  readings.val,
            animationDuration: 0,
          )
        ]);
  }
    return ListView(
      children: <Widget>[
        _buildLiveLineChart()
      ],
    );
  }
}



class LiveData {
  final num val;
  final int x;
 
  LiveData({
    this.val,
    this.x
  });

}