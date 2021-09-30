import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/icons/nano_icons_icons.dart';
import 'package:nanosat/providers/user_provider.dart';
import 'package:nanosat/views/main_tabs/charts/charts.dart';
import 'package:nanosat/views/main_tabs/homepage/homepage.dart';
import 'package:nanosat/views/main_tabs/imaging/imaging.dart';

import 'package:nanosat/views/misc/about/about.dart';
import 'package:nanosat/views/misc/help/help.dart';
import 'package:nanosat/views/misc/settings/settings.dart';
import 'package:nanosat/views/onboarding_screens/landing/landing_page.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  final String firstName;
  final String email;
  MainDrawer({this.firstName, this.email});

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String email;
  @override
  void initState() {
    email = Provider.of<UserProvider>(context, listen: false).email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).cardColor,
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => UserProfile()));
              },
              child: UserAccountsDrawerHeader(
                accountEmail: Text(email),
                accountName: null,
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepPurple[300],
                  radius: 30,
                child: Icon(Icons.person, color: Colors.white)
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.deepPurple, Colors.deepPurple[500]],
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(NanoIcons.home),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Homepage(
                              index: 0,
                            )));
              },
            ),
            ListTile(
              title: Text('Thermal Imaging'),
              leading: Icon(NanoIcons.solar),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Imaging(
                              initialIndex: 0,
                            )));
              },
            ),
               ListTile(
              title: Text('Optical Imaging'),
              leading: Icon(Icons.camera),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Imaging(
                              initialIndex: 1,
                            )));
              },
            ),
            ExpansionTile(
              title: Text('Charts'),
              leading: Icon(
                NanoIcons.analytics,
                // color: Theme.of(context).iconTheme.color,
              ),
              children: <Widget>[
                ListTile(
                  title: Text('Temperature'),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Charts(
                                  initialIndex: 0,
                                )));
                  },
                ),
                ListTile(
                  title: Text('Altitude'),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Charts(
                                  initialIndex: 1,
                                )));
                  },
                ),
                ListTile(
                  title: Text('Battery Info'),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Charts(
                                  initialIndex: 2,
                                )));
                  },
                ),
                ListTile(
                  title: Text('Magnetometer'),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Charts(
                                  initialIndex: 3,
                                )));
                  },
                ),
                ListTile(
                  title: Text('Accelerometer'),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Charts(
                                  initialIndex: 4,
                                )));
                  },
                ),
                ListTile(
                  title: Text('Gyroscope'),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Charts(
                                  initialIndex: 5,
                                )));
                  },
                ),
                ListTile(
                  title: Text(
                    'See All',
                    style: TextStyle(color: Colors.deepPurple[300]),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.deepPurple[300]),
                  onTap: () {
                 Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Charts(
                                        initialIndex: 0,
                                      )));
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                NanoIcons.bell,
                // color: Theme.of(context).iconTheme.color,
              ),
              title: Text('Alerts'),
              onTap: () {
                  Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Homepage(
                                  index: 3,
                                )));
              },
            ),
            ListTile(
              leading: Icon(
                NanoIcons.water,
                // color: Theme.of(context).iconTheme.color,
              ),
              title: Text('Water bodies'),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Imaging(
                              initialIndex: 2,
                            )));
              },
            ),
            ListTile(
              leading: Icon(
                NanoIcons.electricity_tower,
                // color: Theme.of(context).iconTheme.color,
              ),
              title: Text('Rural Lighting'),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Imaging(
                              initialIndex: 1,
                            )));
              },
            ),
            ListTile(
              leading: Icon(
                NanoIcons.trees,
                // color: Theme.of(context).iconTheme.color,
              ),
              title: Text('Vegetation Cover'),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Imaging(
                              initialIndex: 3,
                            )));
              },
            ),
            Divider(color: Colors.blueGrey),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About the Nano Sat'),
              onTap: ()  {
                  Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => About(
                                 
                                )));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () => {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Help()),
                )
              },
            ),
        
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Settings()),
                )
              },
            ),
            Divider(color: Colors.blueGrey),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: (){
                 showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content:
                                    Text('Are you Sure you want to Log Out?'),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                       Navigator.pushAndRemoveUntil(
                                                    context,
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            WelcomePage()),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                      },
                                      child: Text('Yes')),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'))
                                ],
                              );
                            });
                     
              },
            ),
          ],
        ),
      ),
    );
  }
}
