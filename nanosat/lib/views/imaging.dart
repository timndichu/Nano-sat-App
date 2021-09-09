import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/widgets/drawer.dart';

import '../providers/shop_provider.dart';
import '../views/landing_page.dart';
import '../views/user_login.dart';
import 'package:provider/provider.dart';

import 'imaging_types/rural_lighting.dart';
import 'imaging_types/thermal_imaging.dart';
import 'imaging_types/vegetation_cover.dart';
import 'imaging_types/water_bodies.dart';
import 'profile.dart';

class Imaging extends StatefulWidget {
 final int initialIndex;
  Imaging({this.initialIndex});

  @override
  _ImagingState createState() => _ImagingState();
}

class _ImagingState extends State<Imaging> with TickerProviderStateMixin {

  
    TabController _controller;
  int _activeTabIndex = 0;
  
  ScrollController controller;
  @override
  void initState() {
    super.initState();

    _controller =
        TabController(vsync: this, length: 4, initialIndex: widget.initialIndex ?? _activeTabIndex);
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
          title: Text('Satellite Images'),
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
                    indicatorColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        // fontWeight: FontWeight.w600,
                        fontFamily: 'InterRegular'),
                    labelColor: Colors.deepPurple,
                    onTap: (int index) {
                      setState(() {
                        _activeTabIndex = index;
                        _controller.animateTo(index);
                      });
                    },
                    tabs: <Widget>[
                      Tab(text: 'Thermal Imaging'),
                      Tab(text: 'Rural Lighting'),
                      Tab(text: 'Water bodies'),
                      Tab(text: 'Vegetation Cover'),
                 
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      ThermalImaging(),
                      RuralLighting(),
                      WaterBodies(),
                      VegetationCover(),
                      
                    ],
                  ),
                ),
              ],
            ),
          
        ));
  }
}