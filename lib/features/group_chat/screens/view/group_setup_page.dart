import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/features/group_chat/screens/view/widgets/selectable_contact_tile.dart';
import 'package:lanternchat/models/conversations/group_info.dart';
import '../../../../core/router/router_provider.dart';
import '../../../../models/users/contact.dart';
import '../../../contact/provider/contact_providers.dart';

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
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectionStreamProvider = ref.watch(contactStreamProvider);

    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
        centerTitle: true,

        // actions: [ElevatedButton(onPressed: () {}, child: Text('Create'))],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          selectedContactIds.add(currentUser.uid);

          String imageUrl = 'https://api.dicebear.com/7.x/initials/png?seed=Z';

          if (titleController.text.isNotEmpty) {
            final firstLetter = titleController.text.substring(0, 1).toUpperCase();
            imageUrl = 'https://api.dicebear.com/7.x/initials/png?seed=$firstLetter';
          }

          // final imageUrl = 'https://ui-avatars.com/api/?name=A';
          // example 'https://ui-avatars.com/api/?name=LanternChat'

          context.pushReplacement(
            AppRoute.groupChat,
            extra: GroupInfo(
              name: titleController.text,
              imageUrl: imageUrl,
              description: descriptionController.text,
              createdBy: currentUser,
              selectedContactIds: selectedContactIds,
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
