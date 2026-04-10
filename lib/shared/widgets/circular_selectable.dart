import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class CircularSelectable extends StatelessWidget {
  final Widget child;
  final bool selected;

  const CircularSelectable({required this.child, required this.selected, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        if (selected)
          Positioned(
            bottom: -2,
            right: -2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.circle, color: AppColors.background, size: 28),
                Icon(
                  Icons.check_circle,
                  color: AppColors.selectedTileTickColor,
                  // size: 16,
                ),
              ],
            ),
          ),
      ],
    );
  }
}