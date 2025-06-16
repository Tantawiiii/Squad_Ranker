import 'package:flutter/material.dart';

extension AppMediaQueryExtension on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;
  double get viewInsetsLeft => MediaQuery.of(this).viewInsets.left;
  double get viewInsetsRight => MediaQuery.of(this).viewInsets.right;
  double get viewInsetsTop => MediaQuery.of(this).viewInsets.top;
}
