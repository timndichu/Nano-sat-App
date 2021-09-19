import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/widgets/drawer.dart';

import '../providers/shop_provider.dart';
import '../views/landing_page.dart';
import '../views/user_login.dart';
import 'package:provider/provider.dart';

import 'profile.dart';

class Alerts extends StatefulWidget {
  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Alerts'),
          actions: [
            IconButton(
                color: Colors.deepPurple,
                onPressed: () {},
                icon: Icon(Icons.refresh, color: Colors.white))
          ],
        ),
        body: Container(
          
          padding: EdgeInsets.all(16),
          
            child: ListView(children: <Widget>[
          
              Padding(
             padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF404040)),
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 50,
                                  height: 30,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.grey),
                                  child: Center(child: Text('Info'))),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 6.0, right: 4),
                              child: Text('1 hr ago',  style: TextStyle(color: Colors.white
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Satellite transmitted two thermal images to the workstation',  style: TextStyle(color: Colors.white
                              )),
                        )
                      ],
                    )),
              ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                  width: width,
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.amber[600]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 80,
                                  height: 30,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.amber[100]),
                                  child: Center(child: Text('Warning', style: TextStyle(color: Colors.orange[600]),))),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 6.0, right: 4),
                              child: Text('1 day ago',  style: TextStyle(color: Colors.white
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'High power usage',  style: TextStyle(color: Colors.white
                              )),
                        )
                      ],
                  )),
                    ),
                       Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                  width: width,
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red[600]),
                  child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 80,
                                  height: 30,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.red[100]),
                                  child: Center(child: Text('Danger', style: TextStyle(color: Colors.red[600]),))),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 6.0, right: 4),
                              child: Text('3/4/2021',  style: TextStyle(color: Colors.white
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Lora module failure',  style: TextStyle(color: Colors.white
                              )),
                        )
                      ],
                  )),
                    ),
            ]),
          
        ));
  }
}
