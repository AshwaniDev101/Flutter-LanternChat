import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/features/chat/screens/view/widgets/selectable_contact_tile.dart';
import 'package:lanternchat/models/conversations/conversation.dart';
import 'package:lanternchat/models/conversations/conversation_entry.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';
import 'package:lanternchat/models/conversations/group_info.dart';

import '../../../../../core/router/router_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../models/users/contact.dart';
import '../../../contact/provider/contact_providers.dart';
import '../../provider/chat_provider.dart';

class GroupSetupPage extends ConsumerStatefulWidget {
  const GroupSetupPage({super.key});

  @override
  ConsumerState<GroupSetupPage> createState() => _GroupSetupPageState();
}

class _GroupSetupPageState extends ConsumerState<GroupSetupPage> {
  final Set<String> selectedContactIds = {};

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final currentUser = ref.read(currentUserProvider);
    titleController.text = "${currentUser.name.split(' ').first}'s Group";
  }

  Future<ConversationEntry> _createGroupConversation() async {
    final chatService = ref.read(chatServiceProvider);

    final currentUser = ref.watch(currentUserProvider);

    selectedContactIds.add(currentUser.uid);

    // Creating image for group according to the name
    String imageUrl = 'https://api.dicebear.com/7.x/initials/png?seed=Z';
    if (titleController.text.isNotEmpty) {
      final firstLetter = titleController.text.substring(0, 1).toLowerCase();
      imageUrl = 'https://api.dicebear.com/7.x/initials/png?seed=$firstLetter';
    }
    // final imageUrl = 'https://ui-avatars.com/api/?name=A';
    // example 'https://ui-avatars.com/api/?name=LanternChat'

    final groupInfo = GroupInfo(
      title: titleController.text,
      imageUrl: imageUrl,
      description: descriptionController.text,
      createdBy: currentUser,
    );
    // Todo creating an async value provider is great way to process loading state here
    String conversationId = await chatService.createGroupChat(groupInfo: groupInfo, memberIds: selectedContactIds);

    return ConversationEntry(
      conversation: Conversation(
        conversationId: conversationId,
        memberIds: selectedContactIds,
        conversationType: ConversationType.group,
        lastMessagePreview: "${currentUser.name}' started Group",
        lastMessageIndex: 0,
        lastSenderId: currentUser.uid,
        lastMessageTime: Timestamp.now(),
        groupInfo: groupInfo
      ), contact: null,

    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectionStreamProvider = ref.watch(contactStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
        centerTitle: true,

        // actions: [ElevatedButton(onPressed: () {}, child: Text('Create'))],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedContactIds.isNotEmpty? () {
          _createGroupConversation().then((conversationEntry) {
            if (!mounted) return;
            context.pushReplacement(AppRoute.chat, extra: conversationEntry);
          });
        }:(){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Select least 1 Contact'),
            ),
          );
        },
        label: Text('Create'),
        // child: Icon(Icons.arrow_forward_rounded),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              style: const TextStyle(
                color: AppColors.primary, // color of typed text
                fontWeight: FontWeight.bold,
              ),

              decoration: InputDecoration(
                hintText: 'Group name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptionController,

              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),

          Row(
            children: [Padding(padding: const EdgeInsets.all(8.0), child: Text('Select contacts'))],
          ),
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
