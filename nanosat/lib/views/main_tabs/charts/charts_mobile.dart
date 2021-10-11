import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/providers/sensor_readings_provider.dart';
import 'package:nanosat/views/chart_types/accelerometer/accelerometer.dart';
import 'package:nanosat/views/chart_types/altitude/altitude.dart';
import 'package:nanosat/views/chart_types/battery_info/battery_info.dart';
import 'package:nanosat/views/chart_types/gyroscope/gyroscope.dart';
import 'package:nanosat/views/chart_types/magnetometer/magnetometer.dart';
import 'package:nanosat/views/chart_types/temperature/temperature.dart';
import 'package:nanosat/widgets/drawer.dart';


import 'package:provider/provider.dart';


class ChartsMobile extends StatefulWidget {
  final int initialIndex;
  ChartsMobile({this.initialIndex});
  @override
  _ChartsMobileState createState() => _ChartsMobileState();
}

class _ChartsMobileState extends State<ChartsMobile> with TickerProviderStateMixin {
  TabController _controller;
  int _activeTabIndex = 0;

  ScrollController controller;
  @override
  void initState() {
    super.initState();
    if(widget.initialIndex != null) {
      _activeTabIndex = widget.initialIndex;
    }
    _controller = TabController(
        vsync: this,
        length: 5,
        initialIndex: widget.initialIndex ?? _activeTabIndex);
  }

  bool pasthr = false;
  bool livedata = false;
  bool today = false;
  bool yesterday = false;
  bool pastweek = false;

    Future<void> _refresh() async {
    await Future.delayed(Duration.zero, () {

      if(_activeTabIndex == 0) {
        Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastHourTempReadings();
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getTodaysTemp();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getYesterdayTemp();
                 Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastWeekTemp();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastMonthTemp();
      }
        if(_activeTabIndex == 1) { 
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastHourAltitudeReadings();
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getTodaysAltitude();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getYesterdayAltitude();
                 Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastWeekAltitude();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastMonthAltitude();
        }
         if(_activeTabIndex == 2) { 
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastHourMagnetometerReadings();
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getTodaysMagnetometer();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getYesterdayMagnetometer();
                 Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastWeekMagnetometer();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastMonthMagnetometer();
        }
         if(_activeTabIndex == 3) { 
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastHourAccelerometerReadings();
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getTodaysAccelerometer();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getYesterdayAccelerometer();
                 Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastWeekAccelerometer();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastMonthAccelerometer();
        }
         if(_activeTabIndex == 4) { 
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastHourGyroscopeReadings();
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getTodaysGyroscope();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getYesterdayGyroscope();
                 Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastWeekGyroscope();
                Provider.of<SensorReadingsProvider>(context, listen: false)
                .getPastMonthGyroscope();
        }
       
    });
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Widget roomOneheader() => Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topRight,
                begin: Alignment.bottomLeft,
                colors: [
              Colors.deepPurple,
              Colors.deepPurple[300]
            ])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Filter', style: TextStyle(fontSize: 20, color: Colors.white))),
                Icon(Icons.filter_alt_outlined, color: Colors.white)
              ],
            ),
          ),
        );
   

    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Charts'),
          actions: [
            IconButton(
                color: Colors.deepPurple,
                onPressed: _refresh,
                icon: Icon(Icons.refresh, color: Colors.white))
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () => _showModalBottomSheet(),
        //     child: Icon(Icons.filter_alt_outlined)),
        body: DefaultTabController(
          length: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                color: Theme.of(context).cardColor,
                child: new TabBar(
                  controller: _controller,
                  isScrollable: true,
                  unselectedLabelColor:
                      Theme.of(context).textTheme.headline1.color,
                  unselectedLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'InterRegular'),
                  indicatorColor: Colors.deepPurple[300],
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      // fontWeight: FontWeight.w600,
                      fontFamily: 'InterRegular'),
                  labelColor: Colors.deepPurple[300],
                  onTap: (int index) {
                    setState(() {
                      _activeTabIndex = index;
                      _controller.animateTo(index);
                    });
                  },
                  tabs: <Widget>[
                    Tab(text: 'Temperature'),
                    Tab(text: 'Altitude'),
                
                    Tab(text: 'Magnetometer'),
                    Tab(text: 'Accelerometer'),
                    Tab(text: 'Gyroscope'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    Temperature(),
                    Altitude(),
                  
                    MagnetometerCharts(),
                    AccelerometerCharts(),
                    GyroscopeCharts()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
