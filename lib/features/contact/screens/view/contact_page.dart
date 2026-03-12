import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/helpers/id_helper.dart';
import 'package:lanternchat/core/router/router_provider.dart';
import 'package:lanternchat/features/contact/screens/view/widgets/contact_tile.dart';
import 'package:lanternchat/features/contact/screens/view/widgets/new_button.dart';
import 'package:lanternchat/features/conversation/provider/conversation_provider.dart';
import 'package:lanternchat/models/conversations/conversation_tile.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';

import '../../../../models/conversations/conversation.dart';
import '../../../../models/users/contact.dart';
import '../../../auth/provider/auth_provider.dart';
import '../../provider/contact_providers.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final currentUser = ref.watch(currentUserProvider);

    // final conversationService = ref.read(conversationServiceProvider);
    final AsyncValue<List<Contact>> connectionStreamProvider = ref.watch(contactStreamProvider);

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
                  additionalOption: (
                    icon: Icons.qr_code,
                    onTap: () {
                      context.pushReplacement(AppRoute.qrCode);
                    },
                  ),
                ),
                NewButton(icon: Icons.groups, title: 'New Community', onTap: () {}),
              ],
            ),

            Padding(padding: const EdgeInsets.all(8), child: Text('Contact on LanternChat')),
            Expanded(
              child: connectionStreamProvider.when(
                data: (List<Contact> contacts) {
                  // print("#### print first : ${appUserList.first.photoURL.toString()}");
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContactTile(
                        contact: contacts[index],
                        onClick: () {

                          final conversationTile = ConversationTile(contact: contacts[index], conversation: null);
                          context.pushReplacement(AppRoute.chat, extra: conversationTile);


                        },
                      );
                    },
                  );
                },
                error: (e, t) {
                  print("🔥 ERROR: $e");
                  print("🔥 STACKTRACE: $t");

                  return Center(child: Text('Error $e'));
                },
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
