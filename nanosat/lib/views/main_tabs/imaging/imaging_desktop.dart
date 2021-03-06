import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/providers/sensor_readings_provider.dart';
import 'package:nanosat/views/imaging_types/optical_imaging/optical_imaging.dart';
import 'package:nanosat/views/imaging_types/rural_lighting/rural_lighting.dart';
import 'package:nanosat/views/imaging_types/thermal_imaging/thermal_imaging.dart';
import 'package:nanosat/views/imaging_types/vegetation_cover/vegetation_cover.dart';
import 'package:nanosat/views/imaging_types/water_bodies/water_bodies.dart';
import 'package:nanosat/widgets/drawer.dart';
import 'package:provider/provider.dart';


class ImagingDesktop extends StatefulWidget {
 final int initialIndex;
  ImagingDesktop({this.initialIndex});

  @override
  _ImagingDesktopState createState() => _ImagingDesktopState();
}

class _ImagingDesktopState extends State<ImagingDesktop> with TickerProviderStateMixin {

  
    TabController _controller;
  int _activeTabIndex = 0;
  
  ScrollController controller;
  @override
  void initState() {
    super.initState();

    _controller =
        TabController(vsync: this, length: 5, initialIndex: widget.initialIndex ?? _activeTabIndex);
  }

 Future<void> _refresh() async {
    await Future.delayed(Duration.zero, () {

      if(_activeTabIndex == 0) {
        Provider.of<SensorReadingsProvider>(context, listen: false)
                .getThermalImages();
        
      }
        if(_activeTabIndex == 1) { 
          Provider.of<SensorReadingsProvider>(context, listen: false)
                .getOpticalImages();
        
        }
       
    });
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
            onPressed: _refresh, icon: Icon(Icons.refresh, color: Colors.white))],
        ),
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
                      Tab(text: 'Thermal Imaging'),
                      Tab(text: 'Optical Imaging'),
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
                           OpticalImaging(),
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