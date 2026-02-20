
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _searchBar(),
          _getConversionList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add_comment_rounded), onPressed: () {

        context.go('/select-contact');
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

  Widget _getConversionList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _card(index);
        },
      ),
    );
  }

  Widget _card(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.blue),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(children: [Text("Name $index :"), Spacer(), Text("1/12/26")]),

                  Row(
                    children: [Text("Message: $index some randoge"), Spacer(), Icon(Icons.push_pin_rounded, size: 16)],
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
