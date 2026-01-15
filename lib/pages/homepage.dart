import 'package:flutter/material.dart';

enum _HomepageMenuActions { newGroup, newCommunity, broadcastList, linkedDevices, starred, payments, readAll, settings }

extension on _HomepageMenuActions {
  String get label {
    return switch (this) {
      _HomepageMenuActions.newGroup => 'New Group',
      _HomepageMenuActions.newCommunity => 'New Community',
      _HomepageMenuActions.broadcastList => 'Broadcast list',
      _HomepageMenuActions.linkedDevices => 'Linked Devices',
      _HomepageMenuActions.starred => 'Starred',
      _HomepageMenuActions.payments => 'Payments',
      _HomepageMenuActions.readAll => 'Read all',
      _HomepageMenuActions.settings => 'Settings',
    };
  }

  bool get isAttention {
    return _handleAttention(this);
  }
}

bool _handleAttention(_HomepageMenuActions action) {
  if (action == _HomepageMenuActions.linkedDevices) {
    return true;
  }
  return false;
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LanternChat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code_scanner_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
          PopupMenuButton<_HomepageMenuActions>(
            itemBuilder: (context) {
              return _HomepageMenuActions.values.map((menuAction) {
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
            _searchBar(),
            _getConversionList(),

          ],
        ),
      ),
      bottomNavigationBar: _BottomBar(),
    );
  }

  void _handleMenuAction(_HomepageMenuActions value) {
    switch (value) {
      case _HomepageMenuActions.newGroup:
        break;
      case _HomepageMenuActions.newCommunity:
        break;
      case _HomepageMenuActions.broadcastList:
        break;
      case _HomepageMenuActions.linkedDevices:
        break;
      case _HomepageMenuActions.starred:
        break;
      case _HomepageMenuActions.payments:
        break;
      case _HomepageMenuActions.readAll:
        break;
      case _HomepageMenuActions.settings:
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

  Widget _card(int index)
  {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(width: 40,height: 40,  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),color: Colors.blue),),
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
                      Icon(Icons.push_pin_rounded,size: 16,)
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

  Widget _BottomBar()
  {
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
