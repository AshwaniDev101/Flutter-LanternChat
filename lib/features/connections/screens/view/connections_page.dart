import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/rooter/router_provider.dart';
import 'package:lanternchat/features/connections/screens/view/widgets/contact.dart';
import 'package:lanternchat/features/connections/screens/view/widgets/new_button.dart';

import '../../../../../core/providers/constant_providers.dart';
import '../../../../../models/app_user.dart';
import '../../provider/providers.dart';

class ConnectionsPage extends ConsumerWidget {
  const ConnectionsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentUser = ref.watch(firebaseAuthProvider).currentUser;

    final AsyncValue<List<AppUser>> connectionStreamProvider = ref.watch(connectionsStreamProvider(currentUser!.uid));

    // final contactList = ref.watch()
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
                  onTap: () {
                    context.pushReplacement(AppRoute.qrCode);
                  },
                  additionalOption: (icon: Icons.qr_code, onTap: () {}),
                ),
                NewButton(icon: Icons.groups, title: 'New Community', onTap: () {}),
              ],
            ),

            Padding(padding: const EdgeInsets.all(8), child: Text('Contact on LanternChat')),
            Expanded(
              child: connectionStreamProvider.when(
                data: (List<AppUser> appUserList) {
                  // print("#### print first : ${appUserList.first.photoURL.toString()}");
                  return ListView.builder(
                    itemCount: appUserList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Contact(
                        appUser: appUserList[index],
                        onClick: () {

                          // Opening ChatWindow
                          context.pushReplacement(AppRoute.chat, extra: appUserList[index]);
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
