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

  bool _isAltitudeLoading = false;

  bool get isAltitudeLoading {
    return _isAltitudeLoading;
  }

  List<SensorReading> _pastHrAltitude = [];

  List<SensorReading> get pastHrAltitude {
    return List.from(_pastHrAltitude);
  }

  bool _isPastHrAltitudeLoading = false;

  bool get isPastHrAltitudeLoading {
    return _isPastHrAltitudeLoading;
  }

  List<SensorReading> _todayAltitude = [];

  List<SensorReading> get todayAltitude {
    return List.from(_todayAltitude);
  }

  bool _isTodayAltitudeLoading = false;

  bool get isTodayAltitudeLoading {
    return _isTodayAltitudeLoading;
  }

  List<SensorReading> _yesterdayAltitude = [];

  List<SensorReading> get yesterdayAltitude {
    return List.from(_yesterdayAltitude);
  }

  bool _isYesterdayAltitudeLoading = false;

  bool get isYesterdayAltitudeLoading {
    return _isYesterdayAltitudeLoading;
  }

  List<SensorReading> _pastWeekAltitude = [];

  List<SensorReading> get pastWeekAltitude {
    return List.from(_pastWeekAltitude);
  }

  bool _isPastWeekAltitudeLoading = false;

  bool get isPastWeekAltitudeLoading {
    return _isPastWeekAltitudeLoading;
  }

  List<SensorReading> _pastMonthAltitude = [];

  List<SensorReading> get pastMonthAltitude {
    return List.from(_pastMonthAltitude);
  }

  bool _isPastMonthAltitudeLoading = false;

  bool get isPastMonthAltitudeLoading {
    return _isPastMonthAltitudeLoading;
  }

  List<SensorReading> _temperature = [];

  List<SensorReading> get temperature {
    return List.from(_temperature);
  }

  bool _isTempLoading = false;

  bool get isTempLoading {
    return _isTempLoading;
  }

  List<SensorReading> _pastHrTemp = [];

  List<SensorReading> get pastHrTemp {
    return List.from(_pastHrTemp);
  }

  bool _isPastHrTempLoading = false;

  bool get isPastHrTempLoading {
    return _isPastHrTempLoading;
  }

  List<SensorReading> _todayTemp = [];

  List<SensorReading> get todayTemp {
    return List.from(_todayTemp);
  }

  bool _isTodayTempLoading = false;

  bool get isTodayTempLoading {
    return _isTodayTempLoading;
  }

  List<SensorReading> _yesterdayTemp = [];

  List<SensorReading> get yesterdayTemp {
    return List.from(_yesterdayTemp);
  }

  bool _isYesterdayTempLoading = false;

  bool get isYesterdayTempLoading {
    return _isYesterdayTempLoading;
  }

  List<SensorReading> _pastWeekTemp = [];

  List<SensorReading> get pastWeekTemp {
    return List.from(_pastWeekTemp);
  }

  bool _isPastWeekTempLoading = false;

  bool get isPastWeekTempLoading {
    return _isPastWeekTempLoading;
  }

  List<SensorReading> _pastMonthTemp = [];

  List<SensorReading> get pastMonthTemp {
    return List.from(_pastMonthTemp);
  }

  bool _isPastMonthTempLoading = false;

  bool get isPastMonthTempLoading {
    return _isPastMonthTempLoading;
  }

  List<SensorReading> _gyroscope = [];

  List<SensorReading> get gyroscope {
    return List.from(_gyroscope);
  }

  bool _isGyroscopeLoading = false;

  bool get isGyroscopeLoading {
    return _isGyroscopeLoading;
  }

  List<SensorReading> _pastHrGyroscope = [];

  List<SensorReading> get pastHrGyroscope {
    return List.from(_pastHrGyroscope);
  }

  bool _isPastHrGyroscopeLoading = false;

  bool get isPastHrGyroscopeLoading {
    return _isPastHrGyroscopeLoading;
  }

  List<SensorReading> _todayGyroscope = [];

  List<SensorReading> get todayGyroscope {
    return List.from(_todayGyroscope);
  }

  bool _isTodayGyroscopeLoading = false;

  bool get isTodayGyroscopeLoading {
    return _isTodayGyroscopeLoading;
  }

  List<SensorReading> _yesterdayGyroscope = [];

  List<SensorReading> get yesterdayGyroscope {
    return List.from(_yesterdayGyroscope);
  }

  bool _isYesterdayGyroscopeLoading = false;

  bool get isYesterdayGyroscopeLoading {
    return _isYesterdayGyroscopeLoading;
  }

  List<SensorReading> _pastWeekGyroscope = [];

  List<SensorReading> get pastWeekGyroscope {
    return List.from(_pastWeekGyroscope);
  }

  bool _isPastWeekGyroscopeLoading = false;

  bool get isPastWeekGyroscopeLoading {
    return _isPastWeekGyroscopeLoading;
  }

  List<SensorReading> _pastMonthGyroscope = [];

  List<SensorReading> get pastMonthGyroscope {
    return List.from(_pastMonthGyroscope);
  }

  bool _isPastMonthGyroscopeLoading = false;

  bool get isPastMonthGyroscopeLoading {
    return _isPastMonthGyroscopeLoading;
  }

  List<SensorReading> _magnetometer = [];

  List<SensorReading> get magnetometer {
    return List.from(_magnetometer);
  }

  bool _isMagnetometerLoading = false;

  bool get isMagnetometerLoading {
    return _isMagnetometerLoading;
  }

  List<SensorReading> _pastHrMagnetometer = [];

  List<SensorReading> get pastHrMagnetometer {
    return List.from(_pastHrMagnetometer);
  }

  bool _isPastHrMagnetometerLoading = false;

  bool get isPastHrMagnetometerLoading {
    return _isPastHrMagnetometerLoading;
  }

  List<SensorReading> _todayMagnetometer = [];

  List<SensorReading> get todayMagnetometer {
    return List.from(_todayMagnetometer);
  }

  bool _isTodayMagnetometerLoading = false;

  bool get isTodayMagnetometerLoading {
    return _isTodayMagnetometerLoading;
  }

  List<SensorReading> _yesterdayMagnetometer = [];

  List<SensorReading> get yesterdayMagnetometer {
    return List.from(_yesterdayMagnetometer);
  }

  bool _isYesterdayMagnetometerLoading = false;

  bool get isYesterdayMagnetometerLoading {
    return _isYesterdayMagnetometerLoading;
  }

  List<SensorReading> _pastWeekMagnetometer = [];

  List<SensorReading> get pastWeekMagnetometer {
    return List.from(_pastWeekMagnetometer);
  }

  bool _isPastWeekMagnetometerLoading = false;

  bool get isPastWeekMagnetometerLoading {
    return _isPastWeekMagnetometerLoading;
  }

  List<SensorReading> _pastMonthMagnetometer = [];

  List<SensorReading> get pastMonthMagnetometer {
    return List.from(_pastMonthMagnetometer);
  }

  bool _isPastMonthMagnetometerLoading = false;

  bool get isPastMonthMagnetometerLoading {
    return _isPastMonthMagnetometerLoading;
  }

  List<SensorReading> _accelerometer = [];

  List<SensorReading> get accelerometer {
    return List.from(_accelerometer);
  }

  bool _isAccelerometerLoading = false;

  bool get isAccelerometerLoading {
    return _isAccelerometerLoading;
  }

  List<SensorReading> _pastHrAccelerometer = [];

  List<SensorReading> get pastHrAccelerometer {
    return List.from(_pastHrAccelerometer);
  }

  bool _isPastHrAccelerometerLoading = false;

  bool get isPastHrAccelerometerLoading {
    return _isPastHrAccelerometerLoading;
  }

  List<SensorReading> _todayAccelerometer = [];

  List<SensorReading> get todayAccelerometer {
    return List.from(_todayAccelerometer);
  }

  bool _isTodayAccelerometerLoading = false;

  bool get isTodayAccelerometerLoading {
    return _isTodayAccelerometerLoading;
  }

  List<SensorReading> _yesterdayAccelerometer = [];

  List<SensorReading> get yesterdayAccelerometer {
    return List.from(_yesterdayAccelerometer);
  }

  bool _isYesterdayAccelerometerLoading = false;

  bool get isYesterdayAccelerometerLoading {
    return _isYesterdayAccelerometerLoading;
  }

  List<SensorReading> _pastWeekAccelerometer = [];

  List<SensorReading> get pastWeekAccelerometer {
    return List.from(_pastWeekAccelerometer);
  }

  bool _isPastWeekAccelerometerLoading = false;

  bool get isPastWeekAccelerometerLoading {
    return _isPastWeekAccelerometerLoading;
  }

  List<SensorReading> _pastMonthAccelerometer = [];

  List<SensorReading> get pastMonthAccelerometer {
    return List.from(_pastMonthAccelerometer);
  }

  bool _isPastMonthAccelerometerLoading = false;

  bool get isPastMonthAccelerometerLoading {
    return _isPastMonthAccelerometerLoading;
  }

  Future getAccelerometerReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAccelerometer = [];

    _isAccelerometerLoading = true;
    notifyListeners();
    String url = formatter('/getAccelerometerReadings');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedAccelerometer.add(reading);
      });
      _accelerometer = fetchedAccelerometer;

      _isAccelerometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isAccelerometerLoading = false;
      notifyListeners();
    }
  }

  Future getPastHourAccelerometerReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAccelerometer = [];

    _isPastHrAccelerometerLoading = true;
    notifyListeners();
    String url = formatter('/getPastHourAccelerometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedAccelerometer.add(reading);
      });
      _pastHrAccelerometer = fetchedAccelerometer;

      _isPastHrAccelerometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastHrAccelerometerLoading = false;
      notifyListeners();
    }
  }

  Future getTodaysAccelerometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAccelerometer = [];

    _isTodayAccelerometerLoading = true;
    notifyListeners();
    String url = formatter('/getTodaysAccelerometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedAccelerometer.add(reading);
      });
      _todayAccelerometer = fetchedAccelerometer;

      _isTodayAccelerometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isTodayAccelerometerLoading = false;
      notifyListeners();
    }
  }

  Future getYesterdayAccelerometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAccelerometer = [];

    _isYesterdayAccelerometerLoading = true;
    notifyListeners();
    String url = formatter('/getYesterdayAccelerometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedAccelerometer.add(reading);
      });
      _yesterdayAccelerometer = fetchedAccelerometer;

      _isYesterdayAccelerometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isYesterdayAccelerometerLoading = false;
      notifyListeners();
    }
  }

  Future getPastWeekAccelerometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAccelerometer = [];

    _isPastWeekAccelerometerLoading = true;
    notifyListeners();
    String url = formatter('/getPastWeekAccelerometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedAccelerometer.add(reading);
      });
      _pastWeekAccelerometer = fetchedAccelerometer;

      _isPastWeekAccelerometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastWeekAccelerometerLoading = false;
      notifyListeners();
    }
  }

  Future getPastMonthAccelerometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAccelerometer = [];

    _isPastMonthAccelerometerLoading = true;
    notifyListeners();
    String url = formatter('/getPastMonthAccelerometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedAccelerometer.add(reading);
      });
      _pastMonthAccelerometer = fetchedAccelerometer;

      _isPastMonthAccelerometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastMonthAccelerometerLoading = false;
      notifyListeners();
    }
  }

  Future getMagnetometerReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedMagnetometer = [];

    _isMagnetometerLoading = true;
    notifyListeners();
    String url = formatter('/getMagnetometerReadings');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedMagnetometer.add(reading);
      });
      _magnetometer = fetchedMagnetometer;

      _isMagnetometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isMagnetometerLoading = false;
      notifyListeners();
    }
  }

  Future getPastHourMagnetometerReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedMagnetometer = [];

    _isPastHrMagnetometerLoading = true;
    notifyListeners();
    String url = formatter('/getPastHourMagnetometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedMagnetometer.add(reading);
      });
      _pastHrMagnetometer = fetchedMagnetometer;

      _isPastHrMagnetometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastHrMagnetometerLoading = false;
      notifyListeners();
    }
  }

  Future getTodaysMagnetometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedMagnetometer = [];

    _isTodayMagnetometerLoading = true;
    notifyListeners();
    String url = formatter('/getTodaysMagnetometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedMagnetometer.add(reading);
      });
      _todayMagnetometer = fetchedMagnetometer;

      _isTodayMagnetometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isTodayMagnetometerLoading = false;
      notifyListeners();
    }
  }

  Future getYesterdayMagnetometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedMagnetometer = [];

    _isYesterdayMagnetometerLoading = true;
    notifyListeners();
    String url = formatter('/getYesterdayMagnetometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedMagnetometer.add(reading);
      });
      _yesterdayMagnetometer = fetchedMagnetometer;

      _isYesterdayMagnetometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isYesterdayMagnetometerLoading = false;
      notifyListeners();
    }
  }

  Future getPastWeekMagnetometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedMagnetometer = [];

    _isPastWeekMagnetometerLoading = true;
    notifyListeners();
    String url = formatter('/getPastWeekMagnetometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedMagnetometer.add(reading);
      });
      _pastWeekMagnetometer = fetchedMagnetometer;

      _isPastWeekMagnetometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastWeekMagnetometerLoading = false;
      notifyListeners();
    }
  }

  Future getPastMonthMagnetometer() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedMagnetometer = [];

    _isPastMonthMagnetometerLoading = true;
    notifyListeners();
    String url = formatter('/getPastMonthMagnetometer');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedMagnetometer.add(reading);
      });
      _pastMonthMagnetometer = fetchedMagnetometer;

      _isPastMonthMagnetometerLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastMonthMagnetometerLoading = false;
      notifyListeners();
    }
  }

  Future getGyroscopeReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedGyroscope = [];

    _isGyroscopeLoading = true;
    notifyListeners();
    String url = formatter('/getGyroscopeReadings');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedGyroscope.add(reading);
      });
      _gyroscope = fetchedGyroscope;

      _isGyroscopeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isGyroscopeLoading = false;
      notifyListeners();
    }
  }

  Future getPastHourGyroscopeReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedGyroscope = [];

    _isPastHrGyroscopeLoading = true;
    notifyListeners();
    String url = formatter('/getPastHourGyroscope');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedGyroscope.add(reading);
      });
      _pastHrGyroscope = fetchedGyroscope;

      _isPastHrGyroscopeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastHrGyroscopeLoading = false;
      notifyListeners();
    }
  }

  Future getTodaysGyroscope() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedGyroscope = [];

    _isTodayGyroscopeLoading = true;
    notifyListeners();
    String url = formatter('/getTodaysGyroscope');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedGyroscope.add(reading);
      });
      _todayGyroscope = fetchedGyroscope;

      _isTodayGyroscopeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isTodayGyroscopeLoading = false;
      notifyListeners();
    }
  }

  Future getYesterdayGyroscope() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedGyroscope = [];

    _isYesterdayGyroscopeLoading = true;
    notifyListeners();
    String url = formatter('/getYesterdayGyroscope');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedGyroscope.add(reading);
      });
      _yesterdayGyroscope = fetchedGyroscope;

      _isYesterdayGyroscopeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isYesterdayGyroscopeLoading = false;
      notifyListeners();
    }
  }

  Future getPastWeekGyroscope() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedGyroscope = [];

    _isPastWeekGyroscopeLoading = true;
    notifyListeners();
    String url = formatter('/getPastWeekGyroscope');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedGyroscope.add(reading);
      });
      _pastWeekGyroscope = fetchedGyroscope;

      _isPastWeekGyroscopeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastWeekGyroscopeLoading = false;
      notifyListeners();
    }
  }

  Future getPastMonthGyroscope() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedGyroscope = [];

    _isPastMonthGyroscopeLoading = true;
    notifyListeners();
    String url = formatter('/getPastMonthGyroscope');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['altitudes'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedGyroscope.add(reading);
      });
      _pastMonthGyroscope = fetchedGyroscope;

      _isPastMonthGyroscopeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastMonthGyroscopeLoading = false;
      notifyListeners();
    }
  }

  Future getTempReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedTemp = [];

    _isTempLoading = true;
    notifyListeners();
    String url = formatter('/getAllTemperatures');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['temperatures'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedTemp.add(reading);
      });
      _temperature = fetchedTemp;

      _isTempLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isTempLoading = false;
      notifyListeners();
    }
  }

  Future getPastHourTempReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedTemp = [];

    _isPastHrTempLoading = true;
    notifyListeners();
    String url = formatter('/getPastHourTemp');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      print(responseData);

      responseData['temperatures'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedTemp.add(reading);
      });
      _pastHrTemp = fetchedTemp;

      _isPastHrTempLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastHrTempLoading = false;
      notifyListeners();
    }
  }

  Future getTodaysTemp() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedTemp = [];

    _isTodayTempLoading = true;
    notifyListeners();
    String url = formatter('/getTodaysTemp');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      // print(responseData);

      responseData['temperatures'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedTemp.add(reading);
      });
      _todayTemp = fetchedTemp;

      _isTodayTempLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isTodayTempLoading = false;
      notifyListeners();
    }
  }

  Future getYesterdayTemp() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedTemp = [];

    _isYesterdayTempLoading = true;
    notifyListeners();
    String url = formatter('/getYesterdayTemp');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      // print(responseData);

      responseData['temperatures'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedTemp.add(reading);
      });
      _yesterdayTemp = fetchedTemp;

      _isYesterdayTempLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isYesterdayTempLoading = false;
      notifyListeners();
    }
  }

  Future getPastWeekTemp() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedTemp = [];

    _isPastWeekTempLoading = true;
    notifyListeners();
    String url = formatter('/getPastWeekTemp');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      // print(responseData);

      responseData['temperatures'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedTemp.add(reading);
      });
      _pastWeekTemp = fetchedTemp;

      _isPastWeekTempLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastWeekTempLoading = false;
      notifyListeners();
    }
  }

  Future getPastMonthTemp() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedTemp = [];

    _isPastMonthTempLoading = true;
    notifyListeners();
    String url = formatter('/getPastMonthTemp');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);

      // print(responseData);

      responseData['temperatures'].forEach((dynamic sensorReading) {
        final SensorReading reading = SensorReading(
          val: sensorReading['val'],
          time: sensorReading['time'],
          date: sensorReading['date'],
        );
        fetchedTemp.add(reading);
      });
      _pastMonthTemp = fetchedTemp;

      _isPastMonthTempLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastMonthTempLoading = false;
      notifyListeners();
    }
  }

  Future getAltitudeReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAltitude = [];

    _isAltitudeLoading = true;
    notifyListeners();
    String url = formatter('/getAltitudeReadings');

    var response = await http.get(Uri.parse(url));
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

      _isAltitudeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isAltitudeLoading = false;
      notifyListeners();
    }
  }

  Future getPastHourAltitudeReadings() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAltitude = [];

    _isPastHrAltitudeLoading = true;
    notifyListeners();
    String url = formatter('/getPastHourAltitude');

    var response = await http.get(Uri.parse(url));
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
      _pastHrAltitude = fetchedAltitude;

      _isPastHrAltitudeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastHrAltitudeLoading = false;
      notifyListeners();
    }
  }

  Future getTodaysAltitude() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAltitude = [];

    _isTodayAltitudeLoading = true;
    notifyListeners();
    String url = formatter('/getTodaysAltitude');

    var response = await http.get(Uri.parse(url));
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
      _todayAltitude = fetchedAltitude;

      _isTodayAltitudeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isTodayAltitudeLoading = false;
      notifyListeners();
    }
  }

  Future getYesterdayAltitude() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAltitude = [];

    _isYesterdayAltitudeLoading = true;
    notifyListeners();
    String url = formatter('/getYesterdayAltitude');

    var response = await http.get(Uri.parse(url));
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
      _yesterdayAltitude = fetchedAltitude;

      _isYesterdayAltitudeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isYesterdayAltitudeLoading = false;
      notifyListeners();
    }
  }

  Future getPastWeekAltitude() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAltitude = [];

    _isPastWeekAltitudeLoading = true;
    notifyListeners();
    String url = formatter('/getPastWeekAltitude');

    var response = await http.get(Uri.parse(url));
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
      _pastWeekAltitude = fetchedAltitude;

      _isPastWeekAltitudeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastWeekAltitudeLoading = false;
      notifyListeners();
    }
  }

  Future getPastMonthAltitude() async {
    Map<String, dynamic> responseData = {};
    List<SensorReading> fetchedAltitude = [];

    _isPastMonthAltitudeLoading = true;
    notifyListeners();
    String url = formatter('/getPastMonthAltitude');

    var response = await http.get(Uri.parse(url));
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
      _pastMonthAltitude = fetchedAltitude;

      _isPastMonthAltitudeLoading = false;
      notifyListeners();
    } else {
      responseData = json.decode(response.body);

      _isPastMonthAltitudeLoading = false;
      notifyListeners();
    }
  }
}
