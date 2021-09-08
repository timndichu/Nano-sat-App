import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/icons/nano_icons_icons.dart';
import 'package:nanosat/views/alerts.dart';
import 'package:nanosat/views/charts.dart';
import 'package:nanosat/views/imaging.dart';
import 'package:nanosat/widgets/drawer.dart';
import '../models/service.dart';
import '../providers/shop_provider.dart';
import '../views/landing_page.dart';
import '../views/user_login.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'products.dart';
import 'profile.dart';

class Homepage extends StatefulWidget {
  final int index;
  Homepage({this.index});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController _myPage = PageController(initialPage: 0);

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
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
                icon: Icon(NanoIcons.bell,
                    size: 26,
                    color: _currentIndex == 3
                        ? Colors.deepPurple
                        : Colors.grey[700])),
          ],
        ),
        body: _children[_currentIndex]);
  }
}

class HomeScreen extends StatefulWidget {
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
        icon: BitmapDescriptor.defaultMarker
      ),
    );
    super.initState();
  }

  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Home'),
        // actions: [IconButton(
        //      color: Colors.deepPurple,
        //   onPressed: (){

        // }, icon: Icon(Icons.refresh, color: Colors.white), )],
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Container(
        height: height,
        padding: EdgeInsets.all(2),
        child: Column(children: <Widget>[
          Stack(children: [
            Container(
              height: height / 2.2,

              child: GoogleMap(
                  myLocationButtonEnabled: false,
                  mapType: _currentMapType,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (controller) =>
                      _googleMapController = controller,
                  markers: _markers),
            ),
            Positioned(
              right: 4,
              top: 2,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                onPressed: () => _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(_initialCameraPosition),
                ),
                child:
                    const Icon(Icons.center_focus_strong, color: Colors.grey),
              ),
            ),
              Positioned(
              right: 4,
              top: 70,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                onPressed: () {
                  setState(() {
                    _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
                  });
                },
                child:
                    const Icon(Icons.map, color: Colors.grey),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Service service;
  final num index;
  ProductCard({this.service, this.index});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => Products(serviceId: widget.index)),
        );
      },
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.service.imageUrl ??
                      "http://via.placeholder.com/350x150",
                ),
                fit: BoxFit.fill),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(1, 2),
                  blurRadius: 8,
                  spreadRadius: 1)
            ],
            color: Theme.of(context).cardColor),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.4),
                Colors.black.withOpacity(.2),
              ])),
          child: Stack(
            children: <Widget>[
              Center(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(widget.service.title ?? 'Sneakers',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
