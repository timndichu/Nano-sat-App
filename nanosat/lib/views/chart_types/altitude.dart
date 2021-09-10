import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;
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

class Altitude extends StatefulWidget {
  @override
  _AltitudeState createState() => _AltitudeState();
}

class _AltitudeState extends State<Altitude> {
  List<SensorReading> reading;
  bool isLoading = false;
  @override
  void initState() {
    Provider.of<SensorReadingsProvider>(context, listen: false)
                .altitude
                .length >
            0
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
    return ListView(
      children: <Widget>[
        Consumer<SensorReadingsProvider>(
          builder: (context, model, child) {
            Widget content = Center(
                child: Text(
                    'Error fetching data. Check your Internet connection'));

            if (model.isLoading) {
              print(model.altitude);
              content = ShimmerLoader();
            } else if ((model.altitude.length == 0 && !model.isLoading)) {
              content = Center(child: Text('No graph data yet'));
            } else if ((model.altitude.length > 0 && !model.isLoading)) {
              content = GraphWidget(
                readings: model.altitude,
              );
            }

            return content;
          },
        ),
        Consumer<SensorReadingsProvider>(
          builder: (context, model, child) {
            Widget content = Center(
                child: Text(
                    'Error fetching data. Check your Internet connection'));

            if (model.isLoading) {
              print(model.altitude);
              content = ShimmerLoader();
            } else if ((model.altitude.length == 0 && !model.isLoading)) {
              content = Center(child: Text('No graph data yet'));
            } else if ((model.altitude.length > 0 && !model.isLoading)) {
              content = GraphWidget(
                readings: model.altitude,
              );
            }

            return content;
          },
        ),
        Consumer<SensorReadingsProvider>(
          builder: (context, model, child) {
            Widget content = Center(
                child: Text(
                    'Error fetching data. Check your Internet connection'));

            if (model.isLoading) {
              print(model.altitude);
              content = ShimmerLoader();
            } else if ((model.altitude.length == 0 && !model.isLoading)) {
              content = Center(child: Text('No graph data yet'));
            } else if ((model.altitude.length > 0 && !model.isLoading)) {
              content = GraphWidget(
                readings: model.altitude,
              );
            }

            return content;
          },
        ),
      ],
    );
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

  GraphWidget({this.readings});

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
                            builder: (context) =>
                                ExpandedTemp(readings: readings)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Today',
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
        xValueMapper: (SensorReading reading, _) =>
            DateTime.parse(reading.date + " " + reading.time),
        yValueMapper: (SensorReading reading, _) => reading.val,
        name: 'Altitude',
      ),
    ];
  }
}

//Expanded Altitude

class ExpandedTemp extends StatefulWidget {
  final List<SensorReading> readings;

  ExpandedTemp({this.readings});
  @override
  _ExpandedTempState createState() => _ExpandedTempState();
}

class _ExpandedTempState extends State<ExpandedTemp> {
  TrackballBehavior _trackballBehavior;
  final GlobalKey<SfCartesianChartState> _chartKey = GlobalKey();
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Altitude as of 20th September'),
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
    await FileSaveHelper.saveAndLaunchFile(bytes, 'cartesian_chart.pdf');
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      key: _chartKey,
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
        xValueMapper: (SensorReading reading, _) =>
            DateTime.parse(reading.date + " " + reading.time),
        yValueMapper: (SensorReading reading, _) => reading.val,
        name: 'Altitude',
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
