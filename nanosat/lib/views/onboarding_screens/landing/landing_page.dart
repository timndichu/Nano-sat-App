import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/responsiveness/screen_type.dart';
import 'package:nanosat/responsiveness/orientation_layout.dart';

import 'landing_page_desktop.dart';
import 'landing_page_mobile.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: WelcomePageMobilePortrait(),
      //   landscape: WelcomePageMobileLandscape(),
      // ),
      mobile: WelcomePageMobile(),
      tablet: WelcomePageMobile(),
      desktop: WelcomePageDesktop(),
      // tablet: WelcomePageTablet(),
      // desktop: WelcomePageDesktop(),
    );
  }
}

                          