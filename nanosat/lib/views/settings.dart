import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../services/themeprovider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched;
  bool isDark;
   @override
  void initState() {
    isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    isSwitched = isDark ?? false;
    
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 22,
              color: Theme.of(context).textTheme.headline1.color),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: 500,
        child: ListView(
              
              children: <Widget>[
             
              ListTile(
                  leading: Icon(Icons.brightness_6),
                  title: Text(
                    'Dark Mode',
                   
                  ),
                  trailing: Container(
                    width: 60,
                    height: 30,
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          Provider.of<ThemeProvider>(context, listen: false)
                              .swapTheme();
                          print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.deepPurple[200],
                      activeColor: Colors.deepPurple,
                    ),
                  ),
                ),
               
              ],
            ),
      ),
    );
  }
}
