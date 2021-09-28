import 'package:flutter/material.dart';
import 'package:nanosat/providers/sensor_readings_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import './providers/user_provider.dart';
import 'views/main_tabs/charts/charts.dart';
import 'views/onboarding_screens/landing/landing_page.dart';
import 'views/onboarding_screens/landing/landing_page_mobile.dart';
import 'package:provider/provider.dart';

import 'services/themeprovider.dart';

void main() {

    WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;

    return runApp(MultiProvider(child: MyApp(), providers: [
    
      ChangeNotifierProvider<ThemeProvider>(
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
       ChangeNotifierProvider<UserProvider>(
            create: (BuildContext context) {
              return UserProvider();
            },
          ),
          ChangeNotifierProvider<SensorReadingsProvider>(
            create: (BuildContext context) {
              return SensorReadingsProvider();
            },
          ),
    ]));
  });



}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return Consumer<ThemeProvider>(builder: (context, value, child) {
      return MaterialApp(
     
        debugShowCheckedModeBanner: false,
        theme: value.getTheme(),
      title: 'Nano Sat',
    
      home: WelcomePage()
    );
  });}
}
