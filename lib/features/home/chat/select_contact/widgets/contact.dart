import 'package:flutter/material.dart';

import '../../../../../shared/widgets/circular_image.dart';

class Contact extends StatelessWidget {


  final String? imageUrl;
  final String name;
  final String? status;
  const Contact({super.key, this.imageUrl, required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          UserAvatar(
            imageUrl: imageUrl,
          ),

          SizedBox(width: 10,),
          Column(children: [

            Text(name),
            if(status!=null && status!.isNotEmpty)
              Text(status.toString())
          ]),
        ],
      ),
    );
  }
}
