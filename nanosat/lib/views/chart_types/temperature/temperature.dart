import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;

import 'dart:math' as math;


import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:logger/logger.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class Temperature extends StatefulWidget {
  @override
  _TemperatureState createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  
  bool isLoading = false;
  ChartSeriesController _chartSeriesController;
  Timer timer;
   final channel = WebSocketChannel.connect(
    Uri.parse('wss://ksa-nanosat.herokuapp.com'),
  );
  var socketData;
   var log = Logger();
   String str;
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

  

  void _updateDataSource(Timer timer) {
  
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

         StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if(snapshot.hasData) { 
              socketData = snapshot.data;
              
              if(socketData.runtimeType != String){
                 str = new String.fromCharCodes(socketData);
                 print('Data is:');
                 var splitString = str.split('/n');
                 String newString = splitString[0];
                 String removeWeirdChar = newString.replaceAll('\u0000', '');
                 var splitByNewLine = removeWeirdChar.split('\n');
                //   var zeroth = splitByNewLine[0].split(' ');
                //  log.i(zeroth[2]);
                String temp = splitByNewLine[3].trim();
                var splitByComma = temp.split(',');
                String x = splitByComma[1].trim();
                log.i(splitByNewLine);
                LiveData singleData = LiveData(val: int.parse(x), x: count);

                chartData.add(singleData);
                count++;
              }
              
            }
            return  _buildLiveLineChart();
            
          }),


       
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