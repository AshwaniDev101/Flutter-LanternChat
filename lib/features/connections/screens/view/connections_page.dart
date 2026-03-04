
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final connectionProvider = ref.watch(connectionServiceProvider);

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
                  onTap: () {},
                  additionalOption: (icon: Icons.qr_code, onTap: () {}),
                ),
                NewButton(icon: Icons.groups, title: 'New Community', onTap: () {}),
              ],
            ),

            Padding(padding: const EdgeInsets.all(8), child: Text('Contact on LanternChat')),
            Expanded(
              child: StreamBuilder<List<AppUser>>(
                stream: connectionProvider.getConnections(currentUser!.uid),
                builder: (BuildContext context, AsyncSnapshot<List<AppUser>> snapshot) {
                  final List<AppUser> data = snapshot.data!;
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Contact(name: "", status: "", onClick: () {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
