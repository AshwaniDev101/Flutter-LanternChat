import 'package:flutter/material.dart';

@immutable
class CustomTheme extends ThemeExtension<CustomTheme> {
  final Color verticalNavBar;

  final Color verticalIconColor;
  final Color verticalTextColor;
  final Color verticalSelectedBackgroundColor;
  final Color verticalSelectedIconColor;
  final Color verticalSelectedTextColor;

  const CustomTheme({
    required this.verticalNavBar,
    required this.verticalIconColor,
    required this.verticalTextColor,
    required this.verticalSelectedBackgroundColor,
    required this.verticalSelectedIconColor,
    required this.verticalSelectedTextColor,
  });

  @override
  CustomTheme copyWith({
    Color? verticalNavBar,
    Color? verticalIconColor,
    Color? verticalTextColor,
    Color? verticalSelectedBackgroundColor,
    Color? verticalSelectedIconColor,
    Color? verticalSelectedTextColor,
  }) {
    return CustomTheme(
      verticalNavBar: verticalNavBar ?? this.verticalNavBar,
      verticalIconColor: verticalIconColor ?? this.verticalIconColor,
      verticalTextColor: verticalTextColor ?? this.verticalTextColor,
      verticalSelectedBackgroundColor:
      verticalSelectedBackgroundColor ?? this.verticalSelectedBackgroundColor,
      verticalSelectedIconColor:
      verticalSelectedIconColor ?? this.verticalSelectedIconColor,
      verticalSelectedTextColor:
      verticalSelectedTextColor ?? this.verticalSelectedTextColor,
    );
  }

  @override
  CustomTheme lerp(ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) return this;

    return CustomTheme(
      verticalNavBar: Color.lerp(verticalNavBar, other.verticalNavBar, t)!,
      verticalIconColor: Color.lerp(verticalIconColor, other.verticalIconColor, t)!,
      verticalTextColor: Color.lerp(verticalTextColor, other.verticalTextColor, t)!,
      verticalSelectedBackgroundColor: Color.lerp(
        verticalSelectedBackgroundColor,
        other.verticalSelectedBackgroundColor,
        t,
      )!,
      verticalSelectedIconColor: Color.lerp(
        verticalSelectedIconColor,
        other.verticalSelectedIconColor,
        t,
      )!,
      verticalSelectedTextColor: Color.lerp(
        verticalSelectedTextColor,
        other.verticalSelectedTextColor,
        t,
      )!,
    );
  }
}