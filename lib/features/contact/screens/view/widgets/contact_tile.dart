import 'package:flutter/material.dart';

import '../../../../../models/users/app_user.dart';
import '../../../../../models/users/contact.dart';
import '../../../../../shared/widgets/circular_user_avatar.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onClick;

  const ContactTile({super.key, required this.contact, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircularUserAvatar(imageUrl: contact.photoURL),

            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.name, style: Theme.of(context).textTheme.titleSmall),
                Text(contact.email),

                // if(status!=null && status!.isNotEmpty)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
