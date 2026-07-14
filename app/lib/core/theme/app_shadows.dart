import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> get small => const [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get medium => const [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get large => const [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
}
