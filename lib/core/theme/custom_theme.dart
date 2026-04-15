import 'package:flutter/material.dart';

@immutable
class CustomTheme extends ThemeExtension<CustomTheme> {
  final Color verticalNavBar;

  const CustomTheme({
    required this.verticalNavBar,
  });

  @override
  CustomTheme copyWith({
    Color? verticalNavBar,
  }) {
    return CustomTheme(
      verticalNavBar: verticalNavBar ?? this.verticalNavBar,
    );
  }

  @override
  CustomTheme lerp(ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) return this;

    return CustomTheme(
      verticalNavBar: Color.lerp(
        verticalNavBar,
        other.verticalNavBar,
        t,
      )!,
    );
  }
}