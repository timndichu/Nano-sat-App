import 'package:flutter/widgets.dart';
import '../enums/device_screen_type.dart';


DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;

  if (deviceWidth > 950) {
    return DeviceScreenType.Desktop;
  }

  else if (deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  }

else
  return DeviceScreenType.Mobile;
}