import 'package:flutter/material.dart';

class ScreenSizes {
  static const double mobileScreenWidth = 500; 
  static const double tabletScreenWidth = 1024; 
  static const double desktopScreenWidth = 1440; 

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileScreenWidth;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileScreenWidth &&
        MediaQuery.of(context).size.width < tabletScreenWidth;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletScreenWidth;
  }

  static  calculateWidthPercentage(BuildContext context, double percentage) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * percentage / 100.0;
  }
}
