import 'package:flutter/material.dart';

import '../../../../../shared/widgets/circular_user_avatar.dart';

class Contact extends StatelessWidget {


  final String? imageUrl;
  final String name;
  final String? status;
  final VoidCallback onClick;
  const Contact({super.key, this.imageUrl, required this.name, required this.status, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircularUserAvatar(
              imageUrl: imageUrl,
            ),

            SizedBox(width: 10,),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

              Text(name,style: Theme.of(context).textTheme.titleSmall,),
              if(status!=null && status!.isNotEmpty)
                Text(status.toString())
            ]),
          ],
        ),
      ),
    );
  }
}
