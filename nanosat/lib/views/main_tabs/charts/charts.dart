import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/responsiveness/screen_type.dart';
import 'package:nanosat/responsiveness/orientation_layout.dart';


import 'charts_desktop.dart';
import 'charts_mobile.dart';




class Charts extends StatelessWidget {
   final int initialIndex;
  Charts({this.initialIndex});
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: ChartsMobilePortrait(),
      //   landscape: ChartsMobileLandscape(),
      // ),
      mobile: ChartsMobile(initialIndex: initialIndex),
      tablet: ChartsMobile(initialIndex: initialIndex),
      desktop: ChartsDesktop(initialIndex: initialIndex),
      // tablet: ChartsTablet(),
      // desktop: ChartsDesktop(),
    );
  }
}

                          