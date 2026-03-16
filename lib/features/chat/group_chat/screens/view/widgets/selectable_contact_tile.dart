import 'package:flutter/material.dart';

import '../../../../../../models/users/contact.dart';
import '../../../../../../shared/widgets/circular_user_avatar.dart';

class SelectableContactTile extends StatelessWidget {
  final Contact contact;
  final bool isSelected;
  final Function(bool) onChanged;

  const SelectableContactTile({super.key, required this.contact, required this.isSelected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!isSelected);
      },
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

            Spacer(),

            Checkbox(
              value: isSelected,
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
