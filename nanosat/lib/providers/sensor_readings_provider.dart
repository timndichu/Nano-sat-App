import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/sensor_readings.dart';


class SensorReadingsProvider extends ChangeNotifier {
  String baseurl = "https://ksa-nanosat.herokuapp.com";


  String formatter(String url) {
    return baseurl + url;
  }

 List<SensorReading> _altitude = [];

  List<SensorReading> get altitude {
    return List.from(_altitude);
  }

   bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }


  Future getAltitudeReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAltitude = [];


      _isLoading = true;
      notifyListeners();
      String url = formatter('/getAltitudeReadings');

      var response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        responseData = json.decode(response.body);

        print(responseData);

        responseData['altitudes'].forEach((dynamic sensorReading) {
          final SensorReading reading = SensorReading(
             val: sensorReading['val'],
            time: sensorReading['time'],
            date: sensorReading['date'],
        
          );
          fetchedAltitude.add(reading);
        });
        _altitude = fetchedAltitude;

        _isLoading = false;
        notifyListeners();
      } else {
        responseData = json.decode(response.body);

     
        _isLoading = false;
        notifyListeners();
      }
   
  }



}