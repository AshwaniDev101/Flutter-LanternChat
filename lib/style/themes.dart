import 'package:flutter/material.dart';

final Color appbarColors = Colors.blueGrey;
final Color iconColors = Colors.white;

class Themes {
  static final lightThemeData = ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueGrey,
        surface: Colors.blueGrey,
        onSurface: Colors.white,
      ),

    
    appBarTheme: AppBarTheme(backgroundColor: Colors.red,foregroundColor: Colors.white,)
  );
}
