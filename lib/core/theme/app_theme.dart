import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lanternchat/core/theme/custom_theme.dart';

import 'app_colors.dart';
import 'chat_theme.dart';

class Themes {
  static ThemeData get lightThemeData => ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: Colors.black87,

      outlineVariant: Colors.grey.shade400,

    ),

    extensions: [
      ChatTheme(

        // sender
        senderBubble: AppColors.senderBubble,
        senderBubbleTitle: AppColors.senderBubbleTitle,
        senderBubbleText: AppColors.senderBubbleText,
        senderBubbleMuteColor: AppColors.senderBubbleMuteColor,
        senderBubbleDeleted: AppColors.senderBubbleDeleted,


        // received
        receivedBubble: AppColors.receivedBubble,
        receivedBubbleTitle: AppColors.receivedBubbleTitle,
        receivedBubbleText: AppColors.receivedBubbleText,
        receivedBubbleMuteColor: AppColors.receivedBubbleMuteColor,
        receivedBubbleDeleted: AppColors.receivedBubbleDeleted,

        chatBackground: AppColors.chatBackground,
      ),

      CustomTheme(
        verticalNavBar: AppColors.verticalNavigationBarColor,
        verticalIconColor: AppColors.verticalIconColor,
        verticalTextColor: AppColors.verticalTextColor,
        verticalSelectedBackgroundColor: AppColors.verticalSelectedBackgroundColor,
        verticalSelectedIconColor: AppColors.verticalSelectedIconColor,
        verticalSelectedTextColor: AppColors.verticalSelectedTextColor,
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
        outlineVariant: Colors.grey
    ),



    extensions: [
      ChatTheme(

        // sender
        senderBubble: DarkAppColors.senderBubble,
        senderBubbleTitle: DarkAppColors.senderBubbleTitle,
        senderBubbleText: DarkAppColors.senderBubbleText,
        senderBubbleMuteColor: DarkAppColors.senderBubbleMuteColor,
        senderBubbleDeleted: DarkAppColors.senderBubbleDeleted,
        //received
        receivedBubble: DarkAppColors.receivedBubble,
        receivedBubbleTitle: DarkAppColors.receivedBubbleTitle,
        receivedBubbleText: DarkAppColors.receivedBubbleText,
        receivedBubbleMuteColor: DarkAppColors.receivedBubbleMuteColor,
        receivedBubbleDeleted: DarkAppColors.receivedBubbleDeleted,
        // chat background
        chatBackground: DarkAppColors.chatBackground,
      ),
      CustomTheme(
        verticalNavBar: DarkAppColors.verticalNavigationBarColor,
        verticalIconColor: DarkAppColors.verticalIconColor,
        verticalTextColor: DarkAppColors.verticalTextColor,
        verticalSelectedBackgroundColor: DarkAppColors.verticalSelectedBackgroundColor,
        verticalSelectedIconColor: DarkAppColors.verticalSelectedIconColor,
        verticalSelectedTextColor: DarkAppColors.verticalSelectedTextColor,
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
