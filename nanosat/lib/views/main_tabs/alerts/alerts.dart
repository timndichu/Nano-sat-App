import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/responsiveness/screen_type.dart';
import 'package:nanosat/responsiveness/orientation_layout.dart';

import 'alerts_desktop.dart';
import 'alerts_mobile.dart';




class Alerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: AlertsMobilePortrait(),
      //   landscape: AlertsMobileLandscape(),
      // ),
      mobile: AlertsMobile(),
      tablet: AlertsMobile(),
      desktop: AlertsDesktop(),
      // tablet: AlertsTablet(),
      // desktop: AlertsDesktop(),
    );
  }
}

                          