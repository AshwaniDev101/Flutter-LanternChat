import 'package:flutter/material.dart';
import 'package:lanternchat/models/users/user_presence.dart';

import '../../../../../models/users/app_user.dart';
import '../../../../../models/users/contact.dart';
import '../../../../../shared/widgets/circular_user_avatar.dart';

class ContactTile extends StatelessWidget {

  final UserPresence? userPresence;
  final Contact contact;
  final VoidCallback onClick;

  const ContactTile({super.key, required this.contact, required this.onClick, required this.userPresence});

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
                Row(
                  children: [
                    Text(contact.name, style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(width: 8,),
                    if(userPresence!=null && userPresence!.isOnline)

                      Row(
                        children: [
                          Icon(Icons.circle,size: 12,color: Colors.green,),
                          SizedBox(width: 4,),
                          Text('Online',style: TextStyle(color:Colors.green, fontSize: 12, fontWeight: FontWeight.w500),)
                        ],
                      )

                      //
                  ],
                ),
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
