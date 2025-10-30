import 'package:flutter/material.dart';

class AppLayout {
  static double getDeviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getDeviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}
