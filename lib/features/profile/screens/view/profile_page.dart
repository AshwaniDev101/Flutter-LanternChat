import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lanternchat/features/profile/screens/view/widgets/column_button.dart';
import 'package:lanternchat/features/profile/screens/view/widgets/row_button.dart';
import 'package:lanternchat/shared/widgets/circular_user_avatar.dart';

import '../../../../core/router/router_provider.dart';
import '../../../auth/provider/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: CircularUserAvatar(radius: 60, imageUrl: user.photoURL),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(user.name, style: Theme.of(context).textTheme.titleLarge),
                        Text(user.email, style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(onPressed: (){
                        context.push(AppRoute.qrCode);
                      }, icon: Icon(Icons.qr_code,color: Colors.grey[500],size: 32,)),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Expanded(
                      child: RowButton(icon: Icons.message_outlined, title: 'Message'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RowButton(icon: Icons.call_outlined, title: 'Audio'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RowButton(icon: Icons.videocam_outlined, title: 'Video'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RowButton(icon: Icons.note_alt_outlined, title: 'Note'),
                    ),
                  ],
                ),
              ),

              ColumnButton(icon: Icons.notifications_none_outlined, title: 'Notifications'),
              ColumnButton(icon: Icons.star_border_outlined, title: 'Starred messages'),
              ColumnButton(
                icon: Icons.lock_outline_rounded,
                title: 'Encryption',
                subtitle: "Messages and _calls are end-to-end encrypted. Tap to verify",
              ),
              ColumnButton(icon: Icons.timer_outlined, title: 'Disappearing messages', subtitle: 'Off'),
              ColumnButton(
                icon: Icons.mail_lock_outlined,
                title: 'Chat lock',
                subtitle: "Lock and hide this chat on this device",
                showToggle: true,
              ),
              ColumnButton(icon: Icons.privacy_tip_outlined, title: 'Advance chat privacy', subtitle: "Off"),

              // ColumnButton(icon:Icons.logout,title:'Logout',),
              ElevatedButton(
                onPressed: () {
                  ref.read(authManagerProvider).signOut();
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ColumnButton({required IconData icon, required String title, String? subtitle, bool? showToggle}) {
  //   return Material(
  //     child: InkWell(
  //       onTap: () {},
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Row(
  //           children: [
  //             Icon(icon, size: 24),
  //             SizedBox(width: 18),
  //
  //             Expanded(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(title, theme: Theme.of(context).textTheme.titleMedium),
  //
  //                   if (subtitle != null)
  //                     Text(subtitle, softWrap: true, theme: Theme.of(context).textTheme.titleSmall),
  //                 ],
  //               ),
  //             ),
  //
  //             if (showToggle != null && showToggle) Switch(value: false, onChanged: (value) {}),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
