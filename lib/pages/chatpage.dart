import 'package:flutter/material.dart';

class Chatpage extends StatelessWidget {
  const Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Name "),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined)),
          PopupMenuButton(
            itemBuilder: (context) {
              return [];
            },
          ),
        ],
      ),
      body: Column(children: []),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions_outlined)),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
            ),

            IconButton(onPressed: () {}, icon: Icon(Icons.attachment)),
            IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),

            IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
          ],
        ),
      ),
    );
  }
}
