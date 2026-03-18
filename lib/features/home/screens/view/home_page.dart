import 'package:flutter/material.dart';
import 'package:lanternchat/core/theme/app_colors.dart';
import 'package:lanternchat/features/contact/screens/view/contact_page.dart';
import 'package:lanternchat/features/conversation/screens/view/conversation_page.dart';
import 'package:lanternchat/features/conversation/screens/view/group_page.dart';
import 'package:lanternchat/features/profile/screens/view/profile_page.dart';
import 'package:lanternchat/features/qr/screens/view/qr_page.dart';
import 'package:lanternchat/features/settings/screens/view/settings_page.dart';

// enum _HomepagePopupMenu { newGroup, newCommunity, broadcastList, linkedDevices, starred, payments, readAll, settings, profile }
//
// extension on _HomepagePopupMenu {
//   String get label {
//     return switch (this) {
//       _HomepagePopupMenu.newGroup => 'New Group',
//       _HomepagePopupMenu.newCommunity => 'New Community',
//       _HomepagePopupMenu.broadcastList => 'Broadcast list',
//       _HomepagePopupMenu.linkedDevices => 'Linked Devices',
//       _HomepagePopupMenu.starred => 'Starred',
//       _HomepagePopupMenu.payments => 'Payments',
//       _HomepagePopupMenu.readAll => 'Read all',
//       _HomepagePopupMenu.settings => 'Settings',
//       _HomepagePopupMenu.profile => 'Profile',
//     };
//   }
//
//   bool get isAttention {
//     return _handleAttention(this);
//   }
// }
//
// bool _handleAttention(_HomepagePopupMenu action) {
//   if (action == _HomepagePopupMenu.linkedDevices) {
//     return true;
//   }
//   return false;
// }


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;

  final List<Widget> _pages = [

    ConversationPage(),
    ContactPage(),
    // GroupsPage(),
    QrCodePage(),
    // ProfilePage(),
    SettingsPage(),




  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  // void _handleMenuAction(_HomepagePopupMenu value) {
  //   switch (value) {
  //     case _HomepagePopupMenu.newGroup:
  //       break;
  //     case _HomepagePopupMenu.newCommunity:
  //       break;
  //     case _HomepagePopupMenu.broadcastList:
  //       break;
  //     case _HomepagePopupMenu.linkedDevices:
  //       break;
  //     case _HomepagePopupMenu.starred:
  //       break;
  //     case _HomepagePopupMenu.payments:
  //       break;
  //     case _HomepagePopupMenu.readAll:
  //       break;
  //     case _HomepagePopupMenu.settings:
  //       context.push(AppRoute.settings);
  //       break;
  //     case _HomepagePopupMenu.profile:
  //       context.push(AppRoute.profile);
  //       break;
  //   }
  // }



  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.muteColor,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Contacts'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR Code'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],

      onTap: (index){
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}


