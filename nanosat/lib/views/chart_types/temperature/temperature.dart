import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;
import 'package:nanosat/services/themeprovider.dart';
import 'package:provider/provider.dart';
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
  TrackballBehavior _trackballBehavior;
  bool isDark;

  var socketData;
   var log = Logger();
   String str;
  @override
  void initState() {
     timer =
        Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
         isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;

    _trackballBehavior = TrackballBehavior(
        enable: true,
        lineColor: isDark
            ? const Color.fromRGBO(255, 255, 255, 0.03)
            : const Color.fromRGBO(0, 0, 0, 0.03),
        lineWidth: 15,
        activationMode: ActivationMode.singleTap,
        markerSettings: const TrackballMarkerSettings(
            borderWidth: 4,
            height: 10,
            width: 10,
            markerVisibility: TrackballVisibilityMode.visible));
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

    bool _isNumeric(String result) {
    if(result==null){
      return false;
    }
    return double.tryParse(result) != null;
  }

  @override
  Widget build(BuildContext context) {
     SfCartesianChart _buildLiveLineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
         
          trackballBehavior: _trackballBehavior,
          title: ChartTitle(text: 'Live Temperature Readings'),
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
            xValueMapper: (LiveData readings, _) => readings.count,
            yValueMapper: (LiveData readings, _) =>  readings.val,
            animationDuration: 0,
              markerSettings: const MarkerSettings(isVisible: true)
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
                   log.i(splitByNewLine);
               if(splitByNewLine.length > 4) {
                String temp = splitByNewLine[2].trim();
                // var splitByComma = temp.split(',');
                // String x = splitByComma[1].trim();
                 if(_isNumeric(temp) ) {
                   LiveData singleData = LiveData(val: int.parse(temp), count: count);

                chartData.add(singleData);
                count++;
                }
               }
              }
              
            }
             return Card(
                  elevation: 2,
                  
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildLiveLineChart(),
                  ));
            
          }),


       
      ],
    );
  }
}



class LiveData {
  final num val;
  final int count;
 
  LiveData({
    this.val,
    this.count
  });

}