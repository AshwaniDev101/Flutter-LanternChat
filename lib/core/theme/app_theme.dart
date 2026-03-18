import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'chat_theme.dart';

class Themes {
  static ThemeData get lightThemeData => ThemeData(
    useMaterial3: true,
    // colorScheme: ColorScheme.fromSeed(
    //     seedColor: AppColors.primary
    // ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: AppColors.background,
      onSurface: Colors.black87,
    ),

    extensions: [
      ChatTheme(
        senderBubble: AppColors.senderBubble,
        receivedBubble: AppColors.receivedBubble,
        muteColor: AppColors.muteColor,
      ),
    ],
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.statusBar, // background of status bar
        statusBarIconBrightness: Brightness.light, // Android icons
        statusBarBrightness: Brightness.dark, // iOS icons
      ),
    ),
  );

  static ThemeData get darkThemeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: DarkAppColors.primary,
      onPrimary: Colors.white,
      secondary: DarkAppColors.secondary,
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.black,
      surface: DarkAppColors.surface,
      onSurface: Colors.white70,
    ),

    scaffoldBackgroundColor: DarkAppColors.background,

    extensions: [
      ChatTheme(
        senderBubble: DarkAppColors.senderBubble,
        receivedBubble: DarkAppColors.receivedBubble,
        muteColor: DarkAppColors.muteColor,
      ),
    ],

    appBarTheme: AppBarTheme(
      backgroundColor: DarkAppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: DarkAppColors.statusBar,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );
}
