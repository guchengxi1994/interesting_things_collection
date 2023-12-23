import 'package:flutter/material.dart';

class AppStyle {
  static const double appbarHeight = 40;
  static const double sidebarWidth = 150;

  static const double kanbanItemHeight = 100;

  static Color pinCodeColor = const Color.fromARGB(255, 34, 129, 248);

  AppStyle._();

  static const double catalogCardWidth = 100;
  static const double catalogCardHeight = 135;
  static const double catalogOnHoverFactor = 1.1;

  static const leftTopRadius = BorderRadius.only(topLeft: Radius.circular(10));
  static const titleTextColor = Color.fromARGB(255, 117, 117, 117);

  static List<Color> catalogCardBorderColors = [
    Colors.yellow,
    Colors.blue,
    Colors.brown,
    Colors.green,
    Colors.deepPurpleAccent,
    Colors.orange,
    Colors.deepOrangeAccent,
    Colors.pink,
  ];

  static const Color inputFillColor = Color.fromARGB(255, 233, 234, 236);

  static const Color blockedColor = Color.fromRGBO(239, 147, 148, 1);
  static const Color pendingColor = Color.fromRGBO(255, 230, 168, 1);
  static const Color inProgressColor = Colors.blueAccent;
  static const Color doneColor = Colors.greenAccent;
}
