import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BatteryInfo extends StatefulWidget {
  @override
  _BatteryInfoState createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {

   final List<String> _axis = <String>['0(modified)', '0 (default)'].toList();
  //ignore: unused_field
   String _selectedAxisType = '0 (modified)';
   String _selectedAxis;
  double _crossAt = 0;
   TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _selectedAxisType = '0(modified)';
    _selectedAxis = '0(modified)';
    _crossAt = 0;
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildAxisCrossingBaseValueSample()
            ],
          ),
        ));
  }

    
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return Row(
        children: <Widget>[
          Text('Axis base value ',
              style: TextStyle(fontSize: 16.0,)),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            height: 50,
            alignment: Alignment.bottomLeft,
            child: DropdownButton<String>(
                underline: Container(color: const Color(0xFFBDBDBD), height: 1),
                value: _selectedAxis,
                items: _axis.map((String value) {
                  return DropdownMenuItem<String>(
                      value: (value != null) ? value : '0 (modified)',
                      child: Text(value,
                        ));
                }).toList(),
                onChanged: (dynamic value) {
                  _onAxisTypeChange(value.toString());
                  stateSetter(() {});
                }),
          ),
        ],
      );
    });
  }

  /// Returns the spline chart with axis crossing at provided axis value.
  SfCartesianChart _buildAxisCrossingBaseValueSample() {
    return SfCartesianChart(
      margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Battery Info'),
      primaryXAxis: CategoryAxis(
          labelPlacement: LabelPlacement.onTicks,
          majorGridLines: const MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
            
          labelIntersectAction:
              AxisLabelIntersectAction.wrap,
          crossesAt: _crossAt,
          placeLabelsNearAxisLine: false),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          minimum: 0,
          maximum: 100,
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the list of chart series which need to render on
  /// the bar or column chart with axis crossing.
  List<ChartSeries<ChartData, String>> _getSeries() {
    List<ChartSeries<ChartData, String>> chart;
    final List<ChartData> chartData = <ChartData>[
      ChartData('8:30', 80),
     ChartData('8:45', 80),
     ChartData('9:00', 80),
 ChartData('9:15', 80),
  ChartData('9:30', 80),
   ChartData('9:35', 80),
 
     ChartData('9:45', 80),
     ChartData('10:00', 78),
     ChartData('10:15', 77),
     ChartData('10:30', 76),
     ChartData('10:45', 75),
     ChartData('11:00', 74),
    ];
    chart = <ChartSeries<ChartData, String>>[
      AreaSeries<ChartData, String>(
          color: const Color.fromRGBO(75, 135, 185, 0.6),
          borderColor: const Color.fromRGBO(75, 135, 185, 1),
          borderWidth: 2,
          dataSource: chartData,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
    return chart;
  }

  /// Method for updating the axis type on change.
  void _onAxisTypeChange(String item) {
    _selectedAxis = item;
    if (_selectedAxis == '0 (modified)') {
      _selectedAxisType = '0 (modified)';
      _crossAt = 0;
    } else if (_selectedAxis == '0 (default)') {
      _selectedAxisType = '0 (default)';
      _crossAt = 0;
    }
    setState(() {
      /// update the axis type changes
    });
  }
  
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}