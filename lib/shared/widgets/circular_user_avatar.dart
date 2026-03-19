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
                  color: Colors.green,
                  // size: 16,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class CircularUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final IconData placeHolderIcon;

  const CircularUserAvatar({required this.imageUrl, this.radius = 24, this.placeHolderIcon = Icons.person, super.key});

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    // print("### hasImage $hasImage $imageUrl");
    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: hasImage
            ? Image.network(
                imageUrl!,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _placeHolderIcon();
                },
              )
            : _placeHolderIcon(),
      ),
    );
  }

  Widget _placeHolderIcon() {
    return Icon(placeHolderIcon, size: radius);
  }
}
