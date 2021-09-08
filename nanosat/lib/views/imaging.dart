import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/widgets/drawer.dart';
import '../models/service.dart';
import '../providers/shop_provider.dart';
import '../views/landing_page.dart';
import '../views/user_login.dart';
import 'package:provider/provider.dart';

import 'products.dart';
import 'profile.dart';

class Imaging extends StatefulWidget {
 

  @override
  _ImagingState createState() => _ImagingState();
}

class _ImagingState extends State<Imaging> {
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
        body: Container(
          height: height,
          padding: EdgeInsets.all(16),
          child: Column(children: <Widget>[
            
          ]),
        ));
  }
}