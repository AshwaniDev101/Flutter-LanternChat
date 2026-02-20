import 'package:flutter/material.dart';
import 'package:lanternchat/features/home/calls/calls_pages.dart';
import 'package:lanternchat/features/home/chat/chat_page.dart';
import 'package:lanternchat/features/home/communities/communities_page.dart';
import 'package:lanternchat/features/home/update/update_page.dart';

enum _HomepagePopupMenu { newGroup, newCommunity, broadcastList, linkedDevices, starred, payments, readAll, settings }

extension on _HomepagePopupMenu {
  String get label {
    return switch (this) {
      _HomepagePopupMenu.newGroup => 'New Group',
      _HomepagePopupMenu.newCommunity => 'New Community',
      _HomepagePopupMenu.broadcastList => 'Broadcast list',
      _HomepagePopupMenu.linkedDevices => 'Linked Devices',
      _HomepagePopupMenu.starred => 'Starred',
      _HomepagePopupMenu.payments => 'Payments',
      _HomepagePopupMenu.readAll => 'Read all',
      _HomepagePopupMenu.settings => 'Settings',
    };
  }

  bool get isAttention {
    return _handleAttention(this);
  }
}

bool _handleAttention(_HomepagePopupMenu action) {
  if (action == _HomepagePopupMenu.linkedDevices) {
    return true;
  }
  return false;
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;

  final List<Widget> _pages = [

    ChatPage(),
    UpdatePage(),
    CommunitiesPage(),
    CallsPages(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.chat_outlined), onPressed: () {}),
      appBar: AppBar(
        title: Text('LanternChat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code_scanner_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
          PopupMenuButton<_HomepagePopupMenu>(
            itemBuilder: (context) {
              return _HomepagePopupMenu.values.map((menuAction) {
                return PopupMenuItem(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  value: menuAction,
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: menuAction.isAttention ? Colors.amberAccent : Colors.transparent,
                      ),
                      SizedBox(width: 5),
                      Text(menuAction.label),
                    ],
                  ),
                );
              }).toList();
            },

            onSelected: (value) {
              _handleMenuAction(value);
            },
          ),
        ],
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8),
      //   child: Column(
      //     children: [
      //       // Text(user.uid),
      //       SizedBox(height: 14),
      //       _searchBar(),
      //       _getConversionList(),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  void _handleMenuAction(_HomepagePopupMenu value) {
    switch (value) {
      case _HomepagePopupMenu.newGroup:
        break;
      case _HomepagePopupMenu.newCommunity:
        break;
      case _HomepagePopupMenu.broadcastList:
        break;
      case _HomepagePopupMenu.linkedDevices:
        break;
      case _HomepagePopupMenu.starred:
        break;
      case _HomepagePopupMenu.payments:
        break;
      case _HomepagePopupMenu.readAll:
        break;
      case _HomepagePopupMenu.settings:
        break;
    }
  }



  Widget _bottomBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Update'),
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Communities'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'calls'),
      ],

      onTap: (index){

        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}


