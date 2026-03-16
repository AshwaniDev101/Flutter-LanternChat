import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/helpers/timer_formate_helper.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/models/conversations/conversation_tile.dart';

import '../../../../../core/router/router_provider.dart';
import '../../../../shared/widgets/circular_user_avatar.dart';
import '../../provider/conversation_provider.dart';

class ConversationPage extends ConsumerWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentUser = ref.watch(currentUserProvider);

    // return a list of contact and conversation link by memberIds
    final conversationSteam = ref.watch(conversationContactMergeSteamProvider(currentUser.uid));

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            _searchBar(),

            conversationSteam.when(
              data: (List<ConversationTile> tile) {
                // print("##### ${data.length}");
                return _getConversionList(tile);
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
          context.push(AppRoute.selectContact);
        },
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SizedBox(
        height: 42,
        child: TextField(
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

  Widget _getConversionList(List<ConversationTile> conversationTileList) {
    return Expanded(
      child: ListView.builder(
        itemCount: conversationTileList.length,
        itemBuilder: (context, index) {
          return _Card(tile: conversationTileList[index]);
        },
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final ConversationTile tile;

  _Card({required this.tile});

  @override
  Widget build(BuildContext context) {
    if (tile.contact != null) {}

    return InkWell(
      onTap: () {
        context.push(AppRoute.chat, extra: tile);
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
                      Spacer(),
                      if (tile.conversation != null)
                        Text(TimerFormateHelper.formatMessageDate(tile.conversation!.lastMessageTime)),
                    ],
                  ),

                  Row(
                    children: [
                      if (tile.conversation != null)
                        Text(tile.conversation!.lastMessagePreview, style: Theme.of(context).textTheme.bodyMedium),
                      Spacer(),
                      Icon(Icons.push_pin_rounded, size: 16),
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

  // if (tile.conversation != null) {
  //   if (tile.conversation!.groupInfo != null) {
  //
  //   }
  // }

  String _getImageUrl() {
    if (tile.contact != null) {
      return tile.contact!.photoURL;
    } else if (tile.conversation != null && tile.conversation!.groupInfo != null) {
      return tile.conversation!.groupInfo!.imageUrl;
    } else {
      return 'https://ui-avatars.com/api/?name=X';
    }
  }

  String _getName() {
    if (tile.contact != null) {
      return tile.contact!.name;
    } else if (tile.conversation != null && tile.conversation!.groupInfo != null) {
      return tile.conversation!.groupInfo!.title;
    } else {
      return 'O_O user';
    }
  }
}
