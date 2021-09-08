import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/icons/nano_icons_icons.dart';
import 'package:nanosat/views/settings.dart';



class MainDrawer extends StatelessWidget {
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
                accountEmail: Text('nancynjiru@gmail.com'),
                accountName: Text('Nancy'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xffA4312A),
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://www.click042.com/wp-content/uploads/2019/08/images-39.jpeg'),
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
            ListTile(title: Text('Home'), leading: Icon(NanoIcons.home)),
            ListTile(title: Text('Thermal Imaging'), leading: Icon(NanoIcons.solar)),
            ExpansionTile(
              title: Text('Charts'),
              leading: Icon(
                NanoIcons.analytics,
                // color: Theme.of(context).iconTheme.color,
              ),
              children: <Widget>[
                ListTile(
                  title: Text('Temperature'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Altitude'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Battery Info'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Magnetometer'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Accelerometer'),
                  onTap: () {},
                ),
                  ListTile(
                  title: Text('Gyroscope'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'See All',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.deepPurple),
                  onTap: () {
                    //   Navigator.push(
                    //   context,
                    //   CupertinoPageRoute(builder: (context) => Category()),
                    // );
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
                  onTap: () {},
                ),
            ListTile(
               leading: Icon(
                NanoIcons.water,
                // color: Theme.of(context).iconTheme.color,
              ),
              title: Text('Water bodies'),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(builder: (context) => Booking()),
                // )
              },
            ),
              ListTile(
               leading: Icon(
                NanoIcons.electricity_tower,
                // color: Theme.of(context).iconTheme.color,
              ),
              title: Text('Rural Lighting'),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(builder: (context) => Booking()),
                // )
              },
            ),
      
              ListTile(
               leading: Icon(
                NanoIcons.trees,
                // color: Theme.of(context).iconTheme.color,
              ),
              title: Text('Vegetation Cover'),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(builder: (context) => Booking()),
                // )
              },
            ),
         
            Divider(color: Colors.blueGrey),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About the Nano Sat'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(builder: (context) => Uploads()),
                // )
              },
            ),
            Divider(color: Colors.blueGrey),
           
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
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
