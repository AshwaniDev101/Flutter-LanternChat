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

    final conversationSteam = ref.watch(conversationContactMergeSteamProvider(currentUser.uid));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            _searchBar(),

            conversationSteam.when(
              data: (data) {
                // print("##### ${data.length}");
                return _getConversionList(data);
              },
              error: (e, t) {
                print("Error there is an Error $e : $t");
                return Text("Error there is an Error $e");
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
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1,
              ),
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
          return _Card(tile:conversationTileList[index]);
        },
      ),
    );
  }


}


class _Card extends StatelessWidget {

  final ConversationTile tile;

  const _Card({required this.tile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        context.push(AppRoute.chat,extra: tile.contact);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircularUserAvatar(imageUrl: tile.contact.photoURL),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(tile.contact.name,style: Theme.of(context).textTheme.titleSmall,),
                      Spacer(),
                      Text(TimerFormateHelper.formatMessageDate(tile.conversation.lastMessageTime)),
                    ],
                  ),

                  Row(
                    children: [
                      Text(tile.conversation.lastMessagePreview, style: Theme.of(context).textTheme.bodyMedium,),
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
}

