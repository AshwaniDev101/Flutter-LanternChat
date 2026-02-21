import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/providers/auth_provider.dart';
import 'package:lanternchat/core/rooter/router_provider.dart';
import 'package:lanternchat/features/home/chat/select_contact/widgets/contact.dart';
import 'package:lanternchat/features/home/chat/select_contact/widgets/new_button.dart';

class SelectContactPage extends ConsumerWidget {
  const SelectContactPage({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final dummyUser = ref.watch(firebaseAuthProvider).currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Select Contacts')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
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

            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Contact on LanternChat'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Contact(imageUrl: dummyUser?.photoURL,name: dummyUser!.displayName.toString(), status: 'Hello im on LanternChat', onClick:(){

                    context.push(AppRoute.conversation,extra: dummyUser);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
