import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/helpers/id_helper.dart';
import 'package:lanternchat/core/router/router_provider.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/features/auth/provider/presence_provider.dart';
import 'package:lanternchat/features/contact/screens/view/widgets/contact_tile.dart';
import 'package:lanternchat/features/contact/screens/view/widgets/new_button.dart';
import 'package:lanternchat/features/conversation/provider/conversation_provider.dart';
import 'package:lanternchat/models/conversations/conversation_entry.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';

import '../../../../../models/conversations/conversation.dart';
import '../../../../../models/users/contact.dart';
import '../../../../../models/users/user_presence.dart';
import '../../../../shared/widgets/online_status.dart';
import '../../provider/contact_providers.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final currentUser = ref.watch(currentUserProvider);

    // final conversationService = ref.read(conversationServiceProvider);
    final AsyncValue<List<Contact>> connectionStreamProvider = ref.watch(contactStreamProvider);

    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts (${_getCount(connectionStreamProvider)})'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: OnlineUserPresence(uid: currentUser.uid, showOnlyDot: true),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
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
                          final conversationEntry = ConversationEntry(contact: contacts[index], conversation: null);
                          context.push(AppRoute.chat, extra: conversationEntry);
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

  String _getCount(AsyncValue<List<Contact>> connectionStreamProvider) {
    if (connectionStreamProvider.value != null) {
      return connectionStreamProvider.value!.length.toString();
    } else {
      return '';
    }
  }
}
