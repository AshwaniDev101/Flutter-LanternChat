
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/helpers/timer_formate_helper.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/models/conversations/conversation.dart';
import 'package:lanternchat/shared/widgets/circular_user_avatar.dart';

import '../../../../../core/router/router_provider.dart';
import '../../provider/conversation_provider.dart';

class ConversationPage extends ConsumerWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final currentUser = ref.watch(currentUserProvider);

    final conversationSteam = ref.watch(conversationSteamProvider(currentUser.uid));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            _searchBar(),

            conversationSteam.when(data: (data){
              
              // print("##### ${data.length}");
              return _getConversionList(data);
            }, error: (e,t){

              print("Error there is an Error $e : $t");
              return Text("Error there is an Error $e");
            }, loading: (){
              return CircularProgressIndicator();
            })

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add_comment_rounded), onPressed: () {

        context.push(AppRoute.selectContact);
      }),
    );
  }


  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
        ),
      ),
    );
  }

  Widget _getConversionList(List<Conversation> conversationList) {
    return Expanded(
      child: ListView.builder(
        itemCount: conversationList.length,
        itemBuilder: (context, index) {
          return _card(conversationList[index]);
        },
      ),
    );
  }

  Widget _card(Conversation conversation) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircularUserAvatar(imageUrl: conversation.lastSenderPhotoUrl),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(children: [Text("${conversation.lastSenderName} :"), Spacer(), Text(TimerFormateHelper.formatMessageDate(conversation.lastMessageTime))]),

                  Row(
                    children: [Text("${conversation.lastMessagePreview}"), Spacer(), Icon(Icons.push_pin_rounded, size: 16)],
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
