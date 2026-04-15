import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ListItemSelectable extends StatelessWidget {
  final Widget child;
  final bool selected;

  final VoidCallback onTap;
  final void Function(LongPressStartDetails details) onLongPressStart;

  const ListItemSelectable({required this.child, required this.selected, super.key, required this.onLongPressStart, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onLongPressStart,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            child,

            if (selected)
              Positioned(
                bottom: 10,
                left: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.circle, color: AppColors.surface, size: 28),
                    Icon(
                      Icons.check_circle,
                      color: AppColors.selectedTileTickColor,
                      // size: 16,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}