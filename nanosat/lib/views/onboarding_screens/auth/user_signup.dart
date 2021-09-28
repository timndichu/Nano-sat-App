import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/responsiveness/screen_type.dart';
import 'package:nanosat/responsiveness/orientation_layout.dart';

import 'user_signup_desktop.dart';
import 'user_signup_mobile.dart';



class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: SignUpPageMobilePortrait(),
      //   landscape: SignUpPageMobileLandscape(),
      // ),
      mobile: SignUpPageMobile(),
      tablet: SignUpPageMobile(),
      desktop: SignUpPageDesktop(),
      // tablet: SignUpPageTablet(),
      // desktop: SignUpPageDesktop(),
    );
  }
}

                          