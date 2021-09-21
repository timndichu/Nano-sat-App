import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/views/chart_types/accelerometer/accelerometer.dart';
import 'package:nanosat/views/chart_types/altitude/altitude.dart';
import 'package:nanosat/views/chart_types/battery_info/battery_info.dart';
import 'package:nanosat/views/chart_types/gyroscope/gyroscope.dart';
import 'package:nanosat/views/chart_types/altitude/magnetometer.dart';
import 'package:nanosat/views/chart_types/temperature/temperature.dart';
import 'package:nanosat/widgets/drawer.dart';


import 'package:provider/provider.dart';


class ChartsDesktop extends StatefulWidget {
  final int initialIndex;
  ChartsDesktop({this.initialIndex});
  @override
  _ChartsDesktopState createState() => _ChartsDesktopState();
}

class _ChartsDesktopState extends State<ChartsDesktop> with TickerProviderStateMixin {
  TabController _controller;
  int _activeTabIndex = 0;

  ScrollController controller;
  @override
  void initState() {
    super.initState();

    _controller = TabController(
        vsync: this,
        length: 6,
        initialIndex: widget.initialIndex ?? _activeTabIndex);
  }

  bool pasthr = false;
  bool today = false;
  bool yesterday = false;
  bool pastweek = false;
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
    void _showModalBottomSheet() {
      showModalBottomSheet(
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
                            title: Text('Past Hour'),
                            value: pasthr,
                            onChanged: (val) {
                              setState(() {
                                pasthr = val;
                              });
                            }),
                        CheckboxListTile(
                            title: Text('Today'),
                            value: today,
                            onChanged: (val) {
                              setState(() {
                                today = val;
                              });
                            }),
                        CheckboxListTile(
                            title: Text('Yesterday'),
                            value: yesterday,
                            onChanged: (val) {
                              setState(() {
                                yesterday = val;
                              });
                            }),
                        CheckboxListTile(
                            title: Text('Past Week'),
                            value: pastweek,
                            onChanged: (val) {
                              setState(() {
                                pastweek = val;
                              });
                            }),

                            Center(child: RaisedButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text('Apply', style: TextStyle(color: Colors.white)), color: Colors.deepPurple))
                      ],
                    ));
              }));
    }

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
                onPressed: () {},
                icon: Icon(Icons.refresh, color: Colors.white))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _showModalBottomSheet(),
            child: Icon(Icons.filter_alt_outlined)),
        body: DefaultTabController(
          length: 6,
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
                    Tab(text: 'Battery Info'),
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
                    BatteryInfo(),
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
