import 'package:flutter/material.dart';

final Color appbarColors = Colors.blueGrey;
final Color iconColors = Colors.white;

class Themes {
  static final lightThemeData = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blueGrey,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey,foregroundColor: Colors.white,)
  );
}
