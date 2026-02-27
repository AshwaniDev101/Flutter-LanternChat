import 'package:flutter/material.dart';

class CircularUserAvatar extends StatelessWidget {
  final String?  imageUrl;
  final double radius;
  final IconData placeHolderIcon;

  const CircularUserAvatar({required this.imageUrl, this.radius = 24, this.placeHolderIcon = Icons.person, super.key});


  @override
  Widget build(BuildContext context) {

    final hasImage = imageUrl !=null && imageUrl!.isNotEmpty;
    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: hasImage? Image.network(
          imageUrl!,
          width: radius*2,
          height: radius*2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _placeHolderIcon();
          },
        ) : _placeHolderIcon(),
      ),
    );
  }

  Widget _placeHolderIcon()
  {
    return Icon(placeHolderIcon, size: radius);
  }
}
