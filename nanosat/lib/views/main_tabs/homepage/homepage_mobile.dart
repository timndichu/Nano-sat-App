import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/icons/nano_icons_icons.dart';
import 'package:nanosat/views/main_tabs/alerts/alerts.dart';

import 'package:nanosat/views/main_tabs/alerts/alerts_mobile.dart';
import 'package:nanosat/views/main_tabs/charts/charts.dart';
import 'package:nanosat/views/main_tabs/imaging/imaging.dart';
import 'package:nanosat/widgets/drawer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:transparent_image/transparent_image.dart';


import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class HomepageMobile extends StatefulWidget {
  final int index;
  HomepageMobile({this.index});
  @override
  _HomepageMobileState createState() => _HomepageMobileState();
}

class _HomepageMobileState extends State<HomepageMobile> {
  PageController _myPage = PageController(initialPage: 0);

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _currentIndex = 0;
  bool alertBadgeVisible = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if(_currentIndex == 3) {
        alertBadgeVisible = false;
      }
    });
  }

  @override
  void initState() {
    _currentIndex = widget.index ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [HomeScreen(), Imaging(), Charts(), Alerts()];

    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).cardColor,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).cardColor,
                label: 'Home',
                icon: Icon(NanoIcons.home,
                    size: 26,
                    color: _currentIndex == 0
                        ? Colors.deepPurple
                        : Colors.grey[700])),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).cardColor,
                label: 'Satellite Images',
                icon: Icon(NanoIcons.earth_pictures,
                    size: 26,
                    color: _currentIndex == 1
                        ? Colors.deepPurple
                        : Colors.grey[700])),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).cardColor,
                label: 'Charts',
                icon: Icon(NanoIcons.analytics,
                    size: 26,
                    color: _currentIndex == 2
                        ? Colors.deepPurple
                        : Colors.grey[700])),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).cardColor,
                label: 'Alerts',
                icon: Stack(
                  children: [Icon(NanoIcons.bell,
                      size: 26,
                      color: _currentIndex == 3
                          ? Colors.deepPurple
                          : Colors.grey[700]),
                        alertBadgeVisible ?  Positioned(top: 0, right: 2, child: Container(width:10, height: 10, decoration: BoxDecoration(color: Colors.deepPurple[300], borderRadius: BorderRadius.circular(20)),))
                          : Container(height: 0, width: 0)]
                )),
          ],
        ),
        body: _children[_currentIndex]);
  }
}

class HomeScreen extends StatefulWidget {
    final String firstName;
  final String email;
  HomeScreen({this.firstName, this.email});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  Set<Marker> _markers = {};

  Future<void> _refresh() async {
    await Future.delayed(Duration.zero, () {
      // Provider.of<ShopProvider>(context, listen: false)
      //     .getServices()
      //     .then((value) {
      //   setState(() {
      //     isLoading = false;
      //   });
      // });
    });
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(
      -1.2921,
      36.8219,
    ),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;

  static const LatLng _center = const LatLng(
    -1.2921,
    36.8219,
  );
  LatLng _currentMapPosition = _center;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    //   Provider.of<ShopProvider>(context, listen: false).getServices();
    // });
    _markers.add(
      Marker(
          markerId: MarkerId(_currentMapPosition.toString()),
          position: _currentMapPosition,
          infoWindow: InfoWindow(title: 'You'),
          icon: BitmapDescriptor.defaultMarker),
    );
    super.initState();
  }

  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    SfRadialGauge _buildRadialGauge(BuildContext context) {
      return SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          minimum: 32,
          maximum: 212,
          interval: 36,
          radiusFactor:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 0.5
                  : 0.6,
          labelOffset: 15,
          canRotateLabels: true,
          minorTickStyle: const MinorTickStyle(
              color: Color(0xFF00A8B5),
              thickness: 1.5,
              lengthUnit: GaugeSizeUnit.factor,
              length: 0.07),
          majorTickStyle: const MajorTickStyle(
              color: Color(0xFF00A8B5),
              thickness: 1.5,
              lengthUnit: GaugeSizeUnit.factor,
              length: 0.15),
          axisLineStyle: const AxisLineStyle(
            color: Color(0xFF00A8B5),
            thickness: 3,
          ),
          axisLabelStyle:
              const GaugeTextStyle(color: Color(0xFF00A8B5), fontSize: 12),
        ),
        RadialAxis(
            minimum: 0,
            maximum: 100,
            interval: 10,
            ticksPosition: ElementsPosition.outside,
            labelsPosition: ElementsPosition.outside,
            minorTicksPerInterval: 5,
            radiusFactor: 0.95,
            labelOffset: 15,
            minorTickStyle: const MinorTickStyle(
                thickness: 1.5, length: 0.07, lengthUnit: GaugeSizeUnit.factor),
            majorTickStyle: const MinorTickStyle(
              thickness: 1.5,
              length: 0.15,
              lengthUnit: GaugeSizeUnit.factor,
            ),
            axisLineStyle: const AxisLineStyle(
              thickness: 3,
            ),
            axisLabelStyle: const GaugeTextStyle(fontSize: 12),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 1,
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          child: const Text(
                        '33ft  :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times'),
                      )),
                      Container(
                          child: const Text(
                        ' 20in',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF00A8B5),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times'),
                      ))
                    ],
                  ))
            ],
            pointers: const <GaugePointer>[
              NeedlePointer(
                needleLength: 0.68,
                lengthUnit: GaugeSizeUnit.factor,
                needleStartWidth: 0,
                needleEndWidth: 3,
                value: 33,
                enableAnimation: true,
                knobStyle: KnobStyle(
                    knobRadius: 6.5, sizeUnit: GaugeSizeUnit.logicalPixel),
              )
            ]),
      ]);
    }

    SfRadialGauge _buildTemperatureMonitorExample() {
      return SfRadialGauge(
        animationDuration: 3500,
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
              startAngle: 130,
              endAngle: 50,
              minimum: -50,
              maximum: 150,
              interval: 20,
              minorTicksPerInterval: 9,
              showAxisLine: false,
              radiusFactor: 0.9,
              labelOffset: 8,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: -50,
                    endValue: 0,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromRGBO(34, 144, 199, 0.75)),
                GaugeRange(
                    startValue: 0,
                    endValue: 10,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromRGBO(34, 195, 199, 0.75)),
                GaugeRange(
                    startValue: 10,
                    endValue: 30,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromRGBO(123, 199, 34, 0.75)),
                GaugeRange(
                    startValue: 30,
                    endValue: 40,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromRGBO(238, 193, 34, 0.75)),
                GaugeRange(
                    startValue: 40,
                    endValue: 150,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromRGBO(238, 79, 34, 0.65)),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.35,
                    widget: Container(
                        child: const Text('Temp.°C',
                            style: TextStyle(
                                color: Color(0xFFF8B195), fontSize: 14)))),
                GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.8,
                    widget: Container(
                      child: const Text(
                        '  22.5  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ))
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: 22.5,
                  needleLength: 0.6,
                  lengthUnit: GaugeSizeUnit.factor,
                  needleStartWidth: 0,
                  needleEndWidth: 5,
                  animationType: AnimationType.easeOutBack,
                  enableAnimation: true,
                  animationDuration: 1200,
                  knobStyle: KnobStyle(
                      knobRadius: 0.06,
                      sizeUnit: GaugeSizeUnit.factor,
                      borderColor: const Color(0xFFF8B195),
                      color: Colors.white,
                      borderWidth: 0.035),
                  tailStyle: TailStyle(
                      color: const Color(0xFFF8B195),
                      width: 8,
                      lengthUnit: GaugeSizeUnit.factor,
                      length: 0.2),
                  needleColor: const Color(0xFFF8B195),
                )
              ],
              axisLabelStyle: GaugeTextStyle(fontSize: 12),
              majorTickStyle: const MajorTickStyle(
                  length: 0.25,
                  lengthUnit: GaugeSizeUnit.factor,
                  thickness: 1.5),
              minorTickStyle: const MinorTickStyle(
                  length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1))
        ],
      );
    }

    double _interval = 10;

    return Scaffold(
      drawer: MainDrawer(firstName: widget.firstName, email: widget.email),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Home'),
        actions: [
          IconButton(
            color: Colors.deepPurple,
            onPressed: () {},
            icon: Icon(Icons.refresh, color: Colors.white),
          )
        ],
      ),
      body: Container(
        height: height,
     
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Stack(children: [
              Container(
                height: height / 2,
                child: GoogleMap(
                    myLocationButtonEnabled: false,
                    mapType: _currentMapType,
                      gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
                    zoomControlsEnabled: false,
                    initialCameraPosition: _initialCameraPosition,
                    onMapCreated: (controller) =>
                        _googleMapController = controller,
                    markers: _markers),
              ),
              Positioned(
                right: 4,
                bottom: 2,
                child: FloatingActionButton(
                  heroTag: 'satellite',
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.black,
                  onPressed: () => _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(_initialCameraPosition),
                  ),
                  child:
                      const Icon(Icons.center_focus_strong, color: Colors.white),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 70,
                child: FloatingActionButton(
                     heroTag: 'pan',
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    setState(() {
                      _currentMapType = _currentMapType == MapType.normal
                          ? MapType.satellite
                          : MapType.normal;
                    });
                  },
                  child: const Icon(Icons.map, color: Colors.white),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                      width: width,
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 250,
                                  width: width / 1.8,
                                  child: _buildTemperatureMonitorExample()),
                              Spacer(),
                              Container(
                                  width: width / 3,
                                  child: Text('Latest Temp. reading: 22.5 °C'))
                            ]),
                        Text('*Temp. Readings as of 2020-9-9 10:23'),
                        SizedBox(height: 5)
                      ]))),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    width: width,
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Container(
                            height: 250,
                            width: width / 1.8,
                            child: _buildRadialGauge(context)),
                        Spacer(),
                        Container(
                            width: width / 3,
                            child: Text('Latest Altitude reading: 33 ft'))
                      ]),
                      Text('*Altitude Readings as of 2020-9-9 10:23'),
                      SizedBox(height: 5)
                    ]),
                  )),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    width: width,
                    child: Column(children: [
                      Text('Thermal Imaging', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 5),
                      // Image.network('https://d36nqgmw98q4v5.cloudfront.net/images/Article_Images/ImageForArticle_1105(1).jpg'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: width,
                          height: 200,
                          child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              placeholder: kTransparentImage,
                              image:
                                  'https://d36nqgmw98q4v5.cloudfront.net/images/Article_Images/ImageForArticle_1105(1).jpg'),
                        ),
                      ),
        
                      Text('*Latest Thermal Image as of 2020-9-9 10:23'),
                      SizedBox(height: 10),
                      Container(
                        width: 125,
                        child: ElevatedButton(
                            onPressed: () {
                                Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Imaging(
                                initialIndex: 0,
                              )));
                            },
                            child: Row(children: [
                              Text('View more',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'InterRegular',
                                  )),
                              Icon(Icons.arrow_forward_ios),
                            ]),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0.2),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurple[300]),
                                shape: MaterialStateProperty.all(StadiumBorder()),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.all(10)),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'InterRegular',
                                )))),
                      ),
                      SizedBox(height: 5)
                    ]),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
