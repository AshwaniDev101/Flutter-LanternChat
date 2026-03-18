import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/services/shared_preference/data/shared_preference_manager.dart';
import 'package:lanternchat/core/services/shared_preference/provider/shared_preference_provider.dart';
import 'package:lanternchat/features/settings/screens/view/widgets/list_item.dart';
import 'package:lanternchat/shared/widgets/circular_user_avatar.dart';
import 'package:lanternchat/shared/widgets/online_status.dart';

import '../../../../core/theme/providers/theme_mode_provider.dart';
import '../../../../models/users/user_presence.dart';
import '../../../auth/provider/auth_provider.dart';
import '../../../auth/provider/presence_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentUser = ref.watch(currentUserProvider);
    final spp = ref.read(sharedPreferencesProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Settings"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: []),
                  Column(
                    children: [
                      Row(
                        children: [
                          // _isOnlineWidget(presenceMap[currentUser.uid]),
                          OnlineUserPresence(uid: currentUser.uid),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: CircularUserAvatar(imageUrl: currentUser.photoURL, radius: 40),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              ref.read(authManagerProvider).signOut();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(currentUser.name, style: Theme.of(context).textTheme.titleMedium),
                      Text(currentUser.email, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  Column(
                    children: [
                      // ElevatedButton(onPressed: () {}, child: Text('status')),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10),

              ListItem(
                icon: Icons.dark_mode,
                title: "Dark Theme",
                subtitle: "Switch between light and dark mode",
                onTap: () {
                  final current = ref.read(themeModeProvider);

                  ref.read(themeModeProvider.notifier).state = current == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
              ),
              ListItem(icon: Icons.remove_red_eye_outlined, title: "Online Visibility", subtitle: "Hide your online status from others",onTap: (){

                final bool newValue = !(spp.getBool(SharedData.onlineStatus) ?? true);

                spp.setBool(SharedData.onlineStatus, newValue);

                ref.read(presenceServiceProvider).setOnlineStatus(
                  uid: currentUser.uid,
                  isOnline: newValue,
                );



              },),
              // ListItem(icon: Icons.face, title: "Avatar", subtitle: "Change, hide, profile photo"),
              // ListItem(icon: Icons.list_alt, title: "Contacts", subtitle: "Manage people and groups"),
              // ListItem(icon: Icons.chat_outlined, title: "Chats", subtitle: "Theme, wallpapers, chat history"),
              // ListItem(
              //   icon: Icons.notifications_none_outlined,
              //   title: "Notification",
              //   subtitle: "Manage Notifications",
              // ),
              ListItem(icon: Icons.security_update, title: "Check updates", subtitle: "Keep you app up-to date"),

              SizedBox(height: 20),
              Text("Thanks for using this app", style: Theme.of(context).textTheme.bodySmall),
              Text("Drop a hello on any of my socials", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _isOnlineWidget(UserPresence? userPresence) {
  //
  //
  //
  //   if (userPresence != null && userPresence.isOnline == true) {
  //     return     Row(
  //       children: [
  //         Icon(Icons.circle,size: 12,color: Colors.green,),
  //         SizedBox(width: 4,),
  //         Text('Online',style: TextStyle(color:Colors.green, fontSize: 14, fontWeight: FontWeight.w500),)
  //       ],
  //     );
  //   } else {
  //     return Row(
  //       children: [
  //         Icon(Icons.circle,size: 12,color: Colors.red,),
  //         SizedBox(width: 4,),
  //         Text('Online',style: TextStyle(color:Colors.red, fontSize: 14, fontWeight: FontWeight.w500),)
  //       ],
  //     );
  //   }
  // }
}
