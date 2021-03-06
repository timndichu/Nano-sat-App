import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/models/sensor_readings.dart';
import 'package:nanosat/providers/sensor_readings_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'dart:html';
import 'dart:ui' as dart_ui;
import 'package:nanosat/services/themeprovider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:nanosat/helper/helper.dart' if(dart.library.html) 'package:nanosat/helper/web-helper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class Altitude extends StatefulWidget {

  @override
  _AltitudeState createState() => _AltitudeState();
}

class _AltitudeState extends State<Altitude> {
  bool isLoading = false;
  ChartSeriesController _chartSeriesController;
  Timer timer;
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ksa-nanosat.herokuapp.com'),
  );
  TrackballBehavior _trackballBehavior;
  bool isDark;
  bool pasthr = true;
  bool today = true;
  bool yesterday = true;
  bool pastweek = true;
  bool pastmonth = true;
  bool livedata = true;
  var socketData;
  var log = Logger();
  String str;
  @override
  void initState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
    isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
     Provider.of<SensorReadingsProvider>(context,
                                            listen: false)
                                        .resetAll();
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


      Provider.of<SensorReadingsProvider>(context, listen: false)
                .altitude
                .length >
            0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getAltitudeReadings();
          });

    Provider.of<SensorReadingsProvider>(context, listen: false)
                .pastHrAltitude
                .length >
            0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastHourAltitudeReadings();
          });

    Provider.of<SensorReadingsProvider>(context, listen: false)
                .todayAltitude
                .length >
            0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getTodaysAltitude();
          });

    Provider.of<SensorReadingsProvider>(context, listen: false)
                .yesterdayAltitude
                .length >
            0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getYesterdayAltitude();
          });

    Provider.of<SensorReadingsProvider>(context, listen: false)
                .pastWeekAltitude
                .length >
            0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastWeekAltitude();
          });

    Provider.of<SensorReadingsProvider>(context, listen: false)
                .pastMonthAltitude
                .length >
            0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastMonthAltitude();
          });

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
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  @override
  Widget build(BuildContext context) {
    Widget roomOneheader() => Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.topRight,
                  begin: Alignment.bottomLeft,
                  colors: [Colors.deepPurple, Colors.deepPurple[300]])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Filter',
                        style: TextStyle(fontSize: 20, color: Colors.white))),
                Icon(Icons.filter_alt_outlined, color: Colors.white)
              ],
            ),
          ),
        );
    SfCartesianChart _buildLiveLineChart() {
      return SfCartesianChart(
          plotAreaBorderWidth: 0,
          trackballBehavior: _trackballBehavior,
          title: ChartTitle(text: 'Live Altitude Readings'),
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
                yValueMapper: (LiveData readings, _) => readings.val,
                animationDuration: 0,
                markerSettings: const MarkerSettings(isVisible: true))
          ]);
    }

    _showModalBottomSheet() {
      return showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20))),
          context: context,
          builder: (context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Material(
                    clipBehavior: Clip.antiAlias,
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        roomOneheader(),
                        SizedBox(
                          height: 10.0,
                        ),
                        CheckboxListTile(
                            title: Text('Live Data'),
                            value: livedata,
                            onChanged: (val) {
                              setState(() {
                                Provider.of<SensorReadingsProvider>(context,
                                        listen: false)
                                    .toggleLiveData(livedata);
                                livedata = val;
                                print('Live data is $livedata');
                                // today = false;
                                //  pasthr = false;
                                // yesterday = false;
                                // pastweek = false;
                                // pastmonth = false;
                              });
                            }),
                        CheckboxListTile(
                            title: Text('Today'),
                            value: today,
                            onChanged: (val) {
                              setState(() {
                                Provider.of<SensorReadingsProvider>(context,
                                        listen: false)
                                    .toggleToday(today);
                                today = val;
                                // livedata = false;
                                //  pasthr = false;
                                // yesterday = false;
                                // pastweek = false;
                                // pastmonth = false;
                              });
                            }),
                        CheckboxListTile(
                            title: Text('Yesterday'),
                            value: yesterday,
                            onChanged: (val) {
                              setState(() {
                                Provider.of<SensorReadingsProvider>(context,
                                        listen: false)
                                    .toggleYesterday(yesterday);
                                yesterday = val;
                                //  today = false;
                                //  livedata = false;
                                // pasthr = false;
                                // pastweek = false;
                                // pastmonth = false;
                              });
                            }),
                        CheckboxListTile(
                            title: Text('Past Week'),
                            value: pastweek,
                            onChanged: (val) {
                              setState(() {
                                Provider.of<SensorReadingsProvider>(context,
                                        listen: false)
                                    .togglePastWeek(pastweek);
                                pastweek = val;
                                // livedata = false;
                                //  today = false;
                                // yesterday = false;
                                // pasthr = false;
                                // pastmonth = false;
                              });
                            }),
                        CheckboxListTile(
                            title: Text('Past Month'),
                            value: pastmonth,
                            onChanged: (val) {
                              setState(() {
                                Provider.of<SensorReadingsProvider>(context,
                                        listen: false)
                                    .togglePastMonth(pastmonth);
                                pastmonth = val;
                                //  today = false;
                                // yesterday = false;
                                // livedata = false;
                                // pastweek = false;
                                // pasthr = false;
                              });
                            }),
                        Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              RaisedButton(
                                  onPressed: () {
                                    today = true;
                                    yesterday = true;
                                    livedata = true;
                                    pastweek = true;
                                    pastmonth = true;
                                    Provider.of<SensorReadingsProvider>(context,
                                            listen: false)
                                        .resetAll();

                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Reset',
                                      style: TextStyle(color: Colors.white)),
                                  color: Colors.deepOrange),
                              SizedBox(
                                width: 20,
                              ),
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Apply',
                                      style: TextStyle(color: Colors.white)),
                                  color: Colors.deepPurple),
                            ]))
                      ],
                    ));
              }));
    }

    return Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      socketData = snapshot.data;

                      if (socketData.runtimeType != String) {
                        str = new String.fromCharCodes(socketData);
                        print('Data is:');
                        var splitString = str.split('/n');
                        String newString = splitString[0];
                        String removeWeirdChar =
                            newString.replaceAll('\u0000', '');
                        var splitByNewLine = removeWeirdChar.split('\n');
                        log.i(splitByNewLine);
                        if (splitByNewLine.length > 4) {
                          String temp = splitByNewLine[6].trim();
                          // var splitByComma = temp.split(',');
                          // String x = splitByComma[1].trim();
                          if (_isNumeric(temp)) {
                            LiveData singleData =
                                LiveData(val: int.parse(temp), count: count);

                            chartData.add(singleData);
                            count++;
                          }
                        }
                      }
                    }
                    return Consumer<SensorReadingsProvider>(
                        builder: (context, model, child) {
                      Widget content = model.livedata
                          ? Card(
                              elevation: 2,
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildLiveLineChart(),
                              ))
                          : Container();
                      return content;
                    });
                  }),
                         Consumer<SensorReadingsProvider>(
                builder: (context, model, child) {
                  Widget content = Center(
                      child: Text(
                          'Error fetching data. Check your Internet connection'));
                 
                    if (model.isAltitudeLoading){
                  
                      content = ShimmerLoader();
                    } else if ((model.altitude.length == 0 &&
                        !model.isAltitudeLoading)) {
                      content = Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('No graph data available'),
                      ));
                    } else if ((model.altitude.length > 0 &&
                        !model.isAltitudeLoading)) {
                      content = GraphWidget(
                          readings: model.altitude,
                          label: 'All-Time',
                           title: 'All-Time Altitide Readings',
                          dateType: '');
                    }
                 

                  return content;
                },
              ),
              Consumer<SensorReadingsProvider>(
                builder: (context, model, child) {
                  Widget content = Center(
                      child: Text(
                          'Error fetching data. Check your Internet connection'));
                  if (model.today) {
                    if (model.isTodayAltitudeLoading) {
                      print(model.todayAltitude);
                      content = ShimmerLoader();
                    } else if ((model.todayAltitude.length == 0 &&
                        !model.isTodayAltitudeLoading)) {
                      content = Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('No graph data for Today'),
                      ));
                    } else if ((model.todayAltitude.length > 0 &&
                        !model.isTodayAltitudeLoading)) {
                      content = GraphWidget(
                          readings: model.todayAltitude,
                          label: 'Today',
                            title: 'Today Altitude Readings',
                          dateType: 'Today');
                    }
                  } else {
                    content = Container();
                  }

                  return content;
                },
              ),
              Consumer<SensorReadingsProvider>(
                builder: (context, model, child) {
                  Widget content = Center(
                      child: Text(
                          'Error fetching data. Check your Internet connection'));
                  if (model.yesterday) {
                    if (model.isYesterdayAltitudeLoading) {
                      print(model.yesterdayAltitude);
                      content = ShimmerLoader();
                    } else if ((model.yesterdayAltitude.length == 0 &&
                        !model.isYesterdayAltitudeLoading)) {
                      content = Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('No graph data for Yesterday'),
                      ));
                    } else if ((model.yesterdayAltitude.length > 0 &&
                        !model.isYesterdayAltitudeLoading)) {
                      content = yesterday
                          ? GraphWidget(
                              readings: model.yesterdayAltitude,
                              label: 'Yesterday',
                                title: 'Yesterday Altitude Readings',
                              dateType: 'Yesterday')
                          : Container();
                    }
                  } else {
                    content = Container();
                  }

                  return content;
                },
              ),
              Consumer<SensorReadingsProvider>(
                builder: (context, model, child) {
                  Widget content = Center(
                      child: Text(
                          'Error fetching data. Check your Internet connection'));
                  if (model.pastWeek) {
                    if (model.isPastWeekAltitudeLoading) {
                      print(model.pastWeekAltitude);
                      content = ShimmerLoader();
                    } else if ((model.pastWeekAltitude.length == 0 &&
                        !model.isPastWeekAltitudeLoading)) {
                      content = Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('No graph data for the past week'),
                      ));
                    } else if ((model.pastWeekAltitude.length > 0 &&
                        !model.isPastWeekAltitudeLoading)) {
                      content = GraphWidget(
                        readings: model.pastWeekAltitude,
                        label: 'Past Week',
                           title: 'Past Week Altitude Readings',
                        dateType: 'Past Week',
                      );
                    }
                  } else {
                    content = Container();
                  }

                  return content;
                },
              ),
              Consumer<SensorReadingsProvider>(
                builder: (context, model, child) {
                  Widget content = Center(
                      child: Text(
                          'Error fetching data. Check your Internet connection'));
                  if (model.pastMonth) {
                    if (model.isPastMonthAltitudeLoading) {
                      print(model.pastMonthAltitude);
                      content = ShimmerLoader();
                    } else if ((model.pastMonthAltitude.length == 0 &&
                        !model.isPastMonthAltitudeLoading)) {
                      content = Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('No graph data for the past month'),
                      ));
                    } else if ((model.pastMonthAltitude.length > 0 &&
                        !model.isPastMonthAltitudeLoading)) {
                      content = GraphWidget(
                          readings: model.pastMonthAltitude,
                          label: 'Past Month',
                             title: 'Past Month Altitude Readings',
                          dateType: 'Past Month');
                    }
                  } else {
                    content = Container();
                  }

                  return content;
                },
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 5,
        right: 8,
        child: FloatingActionButton(
            onPressed: () => _showModalBottomSheet(),
            child: Icon(Icons.filter_alt_outlined)),
      )
    ]);
  }
}

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250,
        width: 150,
        child: Shimmer.fromColors(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width / 2,
                    height: 150.0,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.blueGrey,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.blueGrey,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: 40.0,
                  height: 8.0,
                  color: Colors.blueGrey,
                ),
              ],
            ),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true),
      ),
    );
  }
}

class GraphWidget extends StatelessWidget {
  final List<SensorReading> readings;
  final String label;
  final String dateType;
    final String title;
  GraphWidget({this.readings, this.label, this.title, this.dateType});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
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
                            builder: (context) => ExpandedAltitude(
                              title: title,
                                readings: readings, dateType: dateType)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            label,
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
                                      color: Colors.deepPurple[300]),
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
                        child: SampleView(
                          readings: readings,
                          dateType: dateType,
                        )),
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
  final String dateType;
  SampleView({this.readings, this.dateType});
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
  DateFormat dateformat;
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

    if (widget.dateType == 'Today' || widget.dateType == 'Yesterday') {
      dateformat = DateFormat.Hms();
    } else {
      dateformat = DateFormat.Md();
    }
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
          dateFormat: dateformat,
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
        xValueMapper: (SensorReading reading, _) =>
            DateTime.parse(reading.date + " " + reading.time),
        yValueMapper: (SensorReading reading, _) => reading.val,
        name: 'Altitude',
      ),
    ];
  }
}

//Expanded Altitude

class ExpandedAltitude extends StatefulWidget {
   final String title;
  final List<SensorReading> readings;
  final String dateType;
  ExpandedAltitude({this.readings, this.title, this.dateType});
  @override
  _ExpandedAltitudeState createState() => _ExpandedAltitudeState();
}

class _ExpandedAltitudeState extends State<ExpandedAltitude> {
  TrackballBehavior _trackballBehavior;
  final GlobalKey<SfCartesianChartState> _chartKey = GlobalKey();
  List<SensorReading> chartData = <SensorReading>[];
  DateFormat dateformat;
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
    if (widget.dateType == 'Today' || widget.dateType == 'Yesterday') {
      dateformat = DateFormat.Hms();
    } else {
      dateformat = DateFormat.Md();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Altitude Readings'),
          actions: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(milliseconds: 2000),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  content: Text('Chart is being exported as PDF document'),
                ));
                _renderPdf();
              },
              icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
            ),
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: _buildDefaultLineChart()));
  }

  Future<List<int>> _readImageData() async {
    final dart_ui.Image data =
        await _chartKey.currentState.toImage(pixelRatio: 3.0);
    final ByteData bytes =
        await data.toByteData(format: dart_ui.ImageByteFormat.png);
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<void> _renderPdf() async {
    final PdfDocument document = PdfDocument();
    final PdfBitmap bitmap = PdfBitmap(await _readImageData());
     String fileName = 'temperature';
  DateTime now = new DateTime.now();
  String fileName1 = fileName + now.toString() + '.pdf';
    document.pageSettings.orientation =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? PdfPageOrientation.landscape
            : PdfPageOrientation.portrait;
    document.pageSettings.margins.all = 0;
    document.pageSettings.size =
        Size(bitmap.width.toDouble(), bitmap.height.toDouble());
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();
    page.graphics.drawImage(
        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      duration: Duration(milliseconds: 200),
      content: Text('Chart has been exported as PDF document.'),
    ));
    final List<int> bytes = document.save();
 
    document.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, fileName1);
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      key: _chartKey,
      plotAreaBorderWidth: 0,
      tooltipBehavior: TooltipBehavior(enable: true),
      backgroundColor: Theme.of(context).cardColor,
      title: ChartTitle(
          text: widget.title,
          textStyle: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Theme.of(context).textTheme.headline1.color)),
      legend:
          Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          intervalType: DateTimeIntervalType.auto,
          dateFormat: dateformat,
          name: 'Seconds',
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.headline1.color),
          title: AxisTitle(
              text: 'Time',
              textStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Theme.of(context).textTheme.headline1.color)),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.none,
          name: 'Altitude',
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.headline1.color),
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
        xValueMapper: (SensorReading reading, _) =>
            DateTime.parse(reading.date + " " + reading.time),
        yValueMapper: (SensorReading reading, _) => reading.val,
        name: 'Altitude',
      ),
    ];
  }
}

class LiveData {
  final num val;
  final int count;

  LiveData({this.val, this.count});
}
