
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/views/chart_types/accelerometer.dart';
import 'package:nanosat/views/chart_types/gyroscope.dart';
import 'package:nanosat/views/chart_types/magnetometer.dart';
import 'package:nanosat/widgets/drawer.dart';

import '../providers/shop_provider.dart';
import '../views/landing_page.dart';
import '../views/user_login.dart';
import 'package:provider/provider.dart';

import 'chart_types/altitude.dart';
import 'chart_types/battery_info.dart';
import 'chart_types/temperature.dart';

import 'profile.dart';

class Charts extends StatefulWidget {

   final int initialIndex;
  Charts({this.initialIndex});
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> with TickerProviderStateMixin {

    TabController _controller;
  int _activeTabIndex = 0;
  
  ScrollController controller;
  @override
  void initState() {
    super.initState();

    _controller =
        TabController(vsync: this, length: 6, initialIndex: widget.initialIndex ?? _activeTabIndex);
  }


  @override
  Widget build(BuildContext context) {
       final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: MainDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Charts'),
          actions: [IconButton(
               color: Colors.deepPurple,
            onPressed: (){
          
          }, icon: Icon(Icons.refresh, color: Colors.white))],
        ),
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
                   unselectedLabelColor: Theme.of(context).textTheme.headline1.color,
                    unselectedLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                        fontFamily: 'InterRegular'
                    ),
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