import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext{
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  double wp(double fraction) => screenWidth * fraction;
  double hp(double fraction) => screenHeight * fraction;
}
