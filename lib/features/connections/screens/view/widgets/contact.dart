import 'package:flutter/material.dart';

import '../../../../../models/users/app_user.dart';
import '../../../../../shared/widgets/circular_user_avatar.dart';

class Contact extends StatelessWidget {
  final AppUser appUser;
  final VoidCallback onClick;

  const Contact({super.key, required this.appUser, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircularUserAvatar(imageUrl: appUser.photoURL),

            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appUser.name, style: Theme.of(context).textTheme.titleSmall),
                Text(appUser.email),

                // if(status!=null && status!.isNotEmpty)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
