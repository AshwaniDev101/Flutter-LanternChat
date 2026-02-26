import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/user_manager_provider.dart';
import 'package:lanternchat/database/database_provider.dart';

import '../../database/firebase/user_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LanternChat',
                  // style: TextStyle(fontSize: 28, color: Colors.blueGrey[400], fontWeight: FontWeight.bold),
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                SizedBox(width: 10),
                Icon(Icons.wechat_outlined, size: 40, color: Colors.blueGrey[400]),
              ],
            ),
            const SizedBox(height: 60),
            Column(
              children: [
                // _signInButton(Icons.email, 'Email', Colors.deepOrange[400]!, () {}),
                // _signInButton(Icons.call, 'Phone Number', Colors.green[400]!, () {}),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, _) {
                    return _signInButton(Icons.person, 'Google', Colors.deepOrange[400]!, () async {
                      final user = await ref.read(userManagerProvider).signInWithGoogle();

                      if (user != null) {
                        // Add to user user list
                        ref.read(userServiceProvider).addAsNewUser(user);
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton(IconData iconData, String text, Color backgroundColor, void Function() callback) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: callback,

        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: SizedBox(
          width: 140,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: Colors.white),
              SizedBox(width: 10),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
