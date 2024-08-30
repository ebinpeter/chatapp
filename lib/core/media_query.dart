import 'package:flutter/material.dart';

class MediaQueryUtil {

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenAspectRatio(BuildContext context) {
    return MediaQuery.of(context).size.aspectRatio;
  }

  static double widthPercentage(BuildContext context, double percentage) {
    return screenWidth(context) * percentage / 100;
  }

  static double heightPercentage(BuildContext context, double percentage) {
    return screenHeight(context) * percentage / 100;
  }

  static double devicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}
