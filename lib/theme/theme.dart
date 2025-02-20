import 'package:flutter/material.dart';

 abstract class Themes {
  Color get primaryColor => Color(0xFFF6BD00);

  Color get textColor => Color(0xFFFFFFFF);

  Color get background => Color(0xFF121312);

  Color get form => Color(0xFF282A28);

   ThemeData get themeData;
}
