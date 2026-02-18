import 'package:flutter/material.dart';

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
      onSurface: Colors.black,
    ),

    extensions: [
      ChatTheme(
        senderBubble: AppColors.senderBubble,
        receivedBubble: AppColors.receivedBubble,
        muteColor: AppColors.muteColor,
      ),
    ],
    appBarTheme: AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
  );
}
