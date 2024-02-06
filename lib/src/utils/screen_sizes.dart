import 'package:flutter/material.dart';

class ScreenSizes {
  static const double mobileScreenWidth = 670;
  static const double tabletScreenWidth = 1224;
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

  static calculateWidthPercentage(BuildContext context, double percentage) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * percentage / 100.0;
  }

  static getGridItemAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (ScreenSizes.isDesktop(context)) {
      return screenWidth / 7 / (screenWidth / 4 * 0.7);
    } else if (ScreenSizes.isTablet(context)) {
      return screenWidth / 4 / (screenWidth / 1.6 * 0.7);
    } else {
      return screenWidth / 2 / (screenWidth / 1.1 * 0.7);
    }
  }
}
