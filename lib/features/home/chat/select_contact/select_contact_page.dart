import 'package:flutter/material.dart';
import 'package:lanternchat/features/home/chat/select_contact/widgets/new_button.dart';

class SelectContactPage extends StatelessWidget {
  const SelectContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Contacts'),),
      body: Column(
        children: [
          Column(
            children: [
              NewButton(icon: Icons.group_add, title: 'New group', onTap: () {}),

              NewButton(
                icon: Icons.person_add_alt_1,
                title: 'New contact',
                onTap: () {},
                additionalOption: (icon: Icons.qr_code, onTap: () {}),
              ),
              NewButton(icon: Icons.groups, title: 'New Community', onTap: () {}),
            ],
          ),
          Text('Contact on LanternChat'),
          Expanded(child: Column(
            children: [

            ],
          )),
        ],
      ),
    );
  }


}
