import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

/// Package import
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:nanosat/models/sensor_readings.dart';
import 'package:nanosat/providers/sensor_readings_provider.dart';
import 'package:nanosat/services/themeprovider.dart';
import 'package:provider/provider.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class Altitude extends StatefulWidget {
  @override
  _AltitudeState createState() => _AltitudeState();
}

class _AltitudeState extends State<Altitude> {

 List<SensorReading> reading;
   bool isLoading = false;
  @override
  void initState() {
    Provider.of<SensorReadingsProvider>(context, listen: false).altitude.length > 0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getAltitudeReadings();
          });

    super.initState();
  }



 Future<void> _refresh() async {
   
    await Future.delayed(Duration.zero, () {
      Provider.of<SensorReadingsProvider>(context, listen: false)
          .getAltitudeReadings()
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      Column(
                children: <Widget>[
                  Expanded(
                    child: Consumer<SensorReadingsProvider>(
                      builder: (context, model, child) {
                        Widget content =
                            Center(child: Text('Error fetching data. Check your Internet connection'));

                        if (model.isLoading) {
                          print(model.altitude);
                          content = Center(child: CircularProgressIndicator());
                        } else if ((model.altitude.length == 0 &&
                            !model.isLoading)) {
                          content =
                              Center(child: Text('No graph data yet'));
                        } else if ((model.altitude.length > 0 &&
                            !model.isLoading)) {
                          content = GraphWidget(
                                      readings: model.altitude,
                                      );
                        }

                        return content;
                      },
                    ),
                  ),
                ],
              );


    
  }
}

class GraphWidget extends StatelessWidget {
  final List<SensorReading> readings;


  GraphWidget({this.readings});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            elevation: 2,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  splashColor: Colors.grey.withOpacity(0.4),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ExpandedTemp()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Altitude',
                            textAlign: TextAlign.left,
                            softWrap: true,
                            textScaleFactor: 1,
                            overflow: TextOverflow.fade,
                            style:
                                TextStyle(fontSize: 16.0, letterSpacing: 0.2),
                          ),
                          Container(
                              child: Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                              ),
                              Container(
                                height: 24,
                                width: 24,
                                color: Colors.transparent,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: Icon(Icons.open_in_full_outlined,
                                      color: Colors.purple),
                                ),
                              ),
                            ],
                          )),
                        ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: SizedBox(
                        width: double.infinity,
                        height: 230,
                        child: SampleView(readings: readings)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SampleView extends StatefulWidget {
   final List<SensorReading> readings;


  SampleView({this.readings});
  @override
  _SampleViewState createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  TrackballBehavior _trackballBehavior;

  List<SensorReading> chartData = <SensorReading>[];


  Future loadSalesData() async {
  
    setState(() {
      // ignore: always_specify_types
      widget.readings.forEach((reading) {
           chartData.add(reading); 
      });
       // Deserialization step 3
      
    });
  }

  bool isDark;
  @override
  void initState() {
    isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    super.initState();
    loadSalesData();
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
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultLineChart();
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      key: GlobalKey(),
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Altitude Readings'),
      legend:
          Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          intervalType: DateTimeIntervalType.auto,
          dateFormat: DateFormat.Hms(),
      
          name: 'Seconds',
            title: AxisTitle(
              text: 'Time',
              textStyle: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
              )),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.none,
          name: 'Altitude',
          minimum: 10,
          maximum: 110,
          interval: 10,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<SensorReading, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<SensorReading, DateTime>>[
      LineSeries<SensorReading, DateTime>(
        dataSource: chartData,
        xValueMapper: (SensorReading reading, _) => DateTime.parse(reading.date + " " + reading.time),
        yValueMapper: (SensorReading reading, _) => reading.val,
        name: 'Altitude',
      ),
    ];
  }
}

//Expanded Altitude

class ExpandedTemp extends StatefulWidget {
  @override
  _ExpandedTempState createState() => _ExpandedTempState();
}

class _ExpandedTempState extends State<ExpandedTemp> {
  TrackballBehavior _trackballBehavior;

  List<_SampleData> chartData = <_SampleData>[];

  // Method to load Json file from assets.
  Future<String> _loadTempData() async {
    return await rootBundle.loadString('assets/data/sample_data.json');
  }

  Future loadSalesData() async {
    final String jsonString = await _loadTempData(); // Deserialization  step 1
    final dynamic jsonResponse =
        json.decode(jsonString); // Deserialization  step 2
    setState(() {
      // ignore: always_specify_types
      for (final Map i in jsonResponse) {
        chartData.add(_SampleData.fromJson(i)); // Deserialization step 3
      }
    });
  }

  bool isDark;
  @override
  void initState() {
    isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    super.initState();
    loadSalesData();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Altitude as of 20th September')),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: _buildDefaultLineChart()));
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      key: GlobalKey(),
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Altitude Against Time'),
      legend:
          Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          intervalType: DateTimeIntervalType.years,
          dateFormat: DateFormat.y(),
          title: AxisTitle(
              text: 'Years',
              textStyle: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
              )),
          name: 'Years',

          placeLabelsNearAxisLine: true,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.none,
          name: 'Temp',
          labelFormat: '{value}°C',
          
          minimum: 70,
          maximum: 110,
          interval: 10,
          axisLine: const AxisLine(width: 0),
          associatedAxisName: 'Temp in degrees celsius',
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_SampleData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<_SampleData, DateTime>>[
      LineSeries<_SampleData, DateTime>(
        dataSource: chartData,
        xValueMapper: (_SampleData sales, _) => sales.date,
        yValueMapper: (_SampleData sales, _) => sales.altitude,
        name: '',
      ),
    ];
  }
}

class _SampleData {
  _SampleData(this.date, this.altitude, this.time);
  factory _SampleData.fromJson(Map<dynamic, dynamic> parsedJson) {
    return _SampleData(
      DateTime.parse(parsedJson['date']),
      parsedJson['altitude'],
      DateTime.parse(parsedJson['time']),
    );
  }
  DateTime date;
  num altitude;
  DateTime time;
}
