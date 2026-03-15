import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/features/chat/provider/chat_provider.dart';
import 'package:lanternchat/features/group_chat/widgets/selectable_contact_tile.dart';

import '../../core/router/router_provider.dart';
import '../../models/conversations/conversation_tile.dart';
import '../../models/users/contact.dart';
import '../contact/provider/contact_providers.dart';
import '../contact/screens/view/widgets/contact_tile.dart';

class GroupSetupPage extends ConsumerStatefulWidget {
  const GroupSetupPage({super.key});

  @override
  ConsumerState<GroupSetupPage> createState() => _GroupSetupPageState();
}

class _GroupSetupPageState extends ConsumerState<GroupSetupPage> {


  final Set<String> selectedContactIds = {};

@override
  Widget build(BuildContext context) {
    final connectionStreamProvider = ref.watch(contactStreamProvider);

    final chatService = ref.watch(chatServiceProvider);
    final currentUser = ref.watch(currentUserProvider);


    return Scaffold(
      appBar: AppBar(title: Text('Select contacts')),

      floatingActionButton: FloatingActionButton(onPressed: () {

        selectedContactIds.add(currentUser.uid);
        chatService.createGroupChat(appUser: currentUser, memberIds: selectedContactIds.toList());

        // ConversationTile ct = ConversationTile(contact: contact, conversation: conversation);

        context.pushReplacement(AppRoute.chat, extra: );



      }, child: Icon(Icons.arrow_forward_rounded)),

      body: Column(
        children: [
          Expanded(
            child: connectionStreamProvider.when(
              data: (List<Contact> contacts) {
                // print("#### print first : ${appUserList.first.photoURL.toString()}");
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SelectableContactTile(
                      contact: contacts[index],
                      isSelected: selectedContactIds.contains(contacts[index].uid),
                      onChanged: (selected) {
                        setState(() {
                          if (selected) {
                            selectedContactIds.add(contacts[index].uid);
                          } else {
                            selectedContactIds.remove(contacts[index].uid);
                          }
                        });
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
    );
  }
}
