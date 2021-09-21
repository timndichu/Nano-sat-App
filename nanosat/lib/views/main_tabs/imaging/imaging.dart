import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/responsiveness/screen_type.dart';
import 'package:nanosat/responsiveness/orientation_layout.dart';


import 'imaging_desktop.dart';
import 'imaging_mobile.dart';




class Imaging extends StatelessWidget {
   final int initialIndex;
  Imaging({this.initialIndex});
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: ImagingMobilePortrait(),
      //   landscape: ImagingMobileLandscape(),
      // ),
      mobile: ImagingMobile(initialIndex: initialIndex),
      tablet: ImagingMobile(initialIndex: initialIndex),
      desktop: ImagingDesktop(initialIndex: initialIndex),
      // tablet: ImagingTablet(),
      // desktop: ImagingDesktop(),
    );
  }
}

                          