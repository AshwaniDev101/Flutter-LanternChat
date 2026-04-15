import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BubbleSelectable extends StatelessWidget {
  final Widget child;
  final bool selected;
  final void Function(LongPressStartDetails details) onLongPressStart;
  final VoidCallback onTap;

  const BubbleSelectable({required this.selected, required this.onTap, required this.onLongPressStart, required this.child,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onLongPressStart,
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: selected?Colors.grey.shade400 :Colors.transparent,
        ),
        child: InkWell(
          onTap: onTap,

          child: Stack(
            children: [
              child,

              if (selected)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.circle, color: AppColors.surface, size: 28),
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.selectedTileTickColor,
                      // size: 16,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}