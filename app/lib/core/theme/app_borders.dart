import 'package:flutter/material.dart';

class AppBorders {
  AppBorders._();

  static BorderRadius get radiusSmall => BorderRadius.circular(4);
  static BorderRadius get radiusMedium => BorderRadius.circular(8);
  static BorderRadius get radiusLarge => BorderRadius.circular(16);
  static BorderRadius get radiusXLarge => BorderRadius.circular(24);
  static BorderRadius get radiusFull => BorderRadius.circular(999);

  static Border none = Border.all(color: Colors.transparent, width: 0);
}
