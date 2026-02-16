import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {

  // final User user;
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [

            // Text(user.uid),
            _searchBar(),
            _getConversionList(),

          ],
        ),
      ),
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

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
      ),
    );
  }

  Widget _getConversionList() {
    return Expanded(
      child: ListView.builder(itemCount: 10, itemBuilder: (context, index) {
        return _card(index);
      }),
    );
  }

  Widget _card(int index) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(width: 40,
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.blue),),
            SizedBox(width: 10,),
            Expanded(
              child: Column(

                children: [
                  Row(

                    children: [
                      Text("Name $index :"),
                      Spacer(),
                      Text("1/12/26"),
                    ],
                  ),

                  Row(
                    children: [
                      Text("Message: $index some random long very long message"),
                      Spacer(),
                      Icon(Icons.push_pin_rounded, size: 16,)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return BottomNavigationBar(

      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Update'),
        BottomNavigationBarItem(icon: Icon(Icons.groups,), label: 'Communities'),
        BottomNavigationBarItem(icon: Icon(Icons.call,), label: 'Calls'),


      ],
    );
  }
}
