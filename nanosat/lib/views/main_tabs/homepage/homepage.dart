import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/responsiveness/screen_type.dart';
import 'package:nanosat/responsiveness/orientation_layout.dart';


import 'homepage_desktop.dart';
import 'homepage_mobile.dart';




class Homepage extends StatelessWidget {
   final int index;
  Homepage({this.index});
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomepageMobilePortrait(),
      //   landscape: HomepageMobileLandscape(),
      // ),
      mobile: HomepageMobile(index: index,),
      tablet: HomepageMobile(index: index),
      desktop: HomepageDesktop(index: index),
      // tablet: HomepageTablet(),
      // desktop: HomepageDesktop(),
    );
  }
}

                          