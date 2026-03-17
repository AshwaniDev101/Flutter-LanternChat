import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/helpers/timer_formate_helper.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/models/conversations/conversation_entry.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';
import 'package:lanternchat/shared/widgets/online_status.dart';

import '../../../../../core/router/router_provider.dart';
import '../../../../shared/widgets/circular_user_avatar.dart';
import '../../../auth/provider/presence_provider.dart';
import '../../provider/conversation_provider.dart';

final searchTextProvider = StateProvider<String>((ref) => '');

class ConversationPage extends ConsumerWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentUser = ref.watch(currentUserProvider);

    // return a list of contact and conversation link by memberIds
    final conversationSteam = ref.watch(conversationContactMergeSteamProvider(currentUser.uid));

    // Setting User presence Online
    final up = ref.read(presenceServiceProvider);
    up.setOnlineStatus(uid: currentUser.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('All Chats'),
        // title: Text('All Conversations'),
        centerTitle: true,

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: 12,),
            _searchBar(ref),

            conversationSteam.when(
              data: (List<ConversationEntry> conversationEntry) {
                // Search bar logic
                final String searchText = ref.watch(searchTextProvider);
                final filteredList = conversationEntry.where((entry) {
                  String name;
                  if (entry.conversation != null && entry.conversation!.groupInfo != null) {
                    name = entry.conversation!.groupInfo!.title;
                  } else if (entry.contact != null) {
                    name = entry.contact!.name;
                  } else {
                    name = 'O_O user'; // fallback
                  }

                  return name.toLowerCase().contains(searchText.toLowerCase());
                }).toList();

                return _getConversionList(filteredList);
              },
              error: (e, t) {
                print("Error there is an Error $e : $t");
                return Text("Error: there is an Error $e");
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_comment_rounded),
        onPressed: () {
          context.push(AppRoute.messageContact);
        },
      ),
    );
  }

  Widget _searchBar(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SizedBox(
        height: 42,
        child: TextField(
          onChanged: (value) => ref.read(searchTextProvider.notifier).state = value,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey),

            filled: true,
            fillColor: Colors.white,

            contentPadding: EdgeInsets.symmetric(vertical: 0),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getConversionList(List<ConversationEntry> conversationEntryList) {
    return Expanded(
      child: ListView.builder(
        itemCount: conversationEntryList.length,
        itemBuilder: (context, index) {
          return _Card(conversationEntry: conversationEntryList[index]);
        },
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final ConversationEntry conversationEntry;

  _Card({required this.conversationEntry});

  @override
  Widget build(BuildContext context) {
    if (conversationEntry.contact != null) {}

    return InkWell(
      onTap: () {
        context.push(AppRoute.chat, extra: conversationEntry);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircularUserAvatar(imageUrl: _getImageUrl()),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(_getName(), style: Theme.of(context).textTheme.titleSmall),
                      if (conversationEntry.contact != null &&
                          conversationEntry.conversation != null &&
                          conversationEntry.conversation!.conversationType == ConversationType.solo)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: OnlineUserPresence(uid: conversationEntry.contact!.uid, showTextOnly: true, size: 10,),
                        ),
                      Spacer(),
                      Icon(Icons.push_pin_rounded, size: 16),

                    ],
                  ),

                  Row(
                    children: [
                      if (conversationEntry.conversation != null)
                        Text(
                          conversationEntry.conversation!.lastMessagePreview,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      Spacer(),
                      if (conversationEntry.conversation != null)
                        Text(TimeFormatHelper.formatMessageDate(conversationEntry.conversation!.lastMessageTime), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
    contact is null mean it's group conversation group info is not null and type is group
    contact and conversation exist mean is solo conversation existing
    if contact but no conversation mean it new solo conversation
     */

  // if (conversationEntry.conversation != null) {
  //   if (conversationEntry.conversation!.groupInfo != null) {
  //
  //   }
  // }

  String _getImageUrl() {
    if (conversationEntry.conversation != null && conversationEntry.conversation!.groupInfo != null) {
      return conversationEntry.conversation!.groupInfo!.imageUrl;
    } else if (conversationEntry.contact != null) {
      return conversationEntry.contact!.photoURL;
    } else {
      return 'https://ui-avatars.com/api/?name=X';
    }
  }

  String _getName() {
    if (conversationEntry.conversation != null && conversationEntry.conversation!.groupInfo != null) {
      return conversationEntry.conversation!.groupInfo!.title;
    } else if (conversationEntry.contact != null) {
      return conversationEntry.contact!.name;
    } else {
      return 'O_O user';
    }
  }
}
