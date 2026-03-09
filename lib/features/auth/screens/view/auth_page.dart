import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/auth/screens/view/widgets/sign_in_button.dart';

import '../../../../core/firestore/provider/firestore_provider.dart';
import '../../../../models/users/app_user.dart';
import '../../provider/auth_provider.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(Icons.wechat_outlined, size: 40, color: Colors.blueGrey[400]),

            Image.asset(
              'assets/icons/main/lantern_icon.png',
              width: 52,
              height: 52,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20,),

            Text(
              'Welcome to LanternChat',
              // style: TextStyle(fontSize: 28, color: Colors.blueGrey[400], fontWeight: FontWeight.bold),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            Text(
              'Discover people with passions like yours.',
              // style: TextStyle(fontSize: 28, color: Colors.blueGrey[400], fontWeight: FontWeight.bold),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  SignInButton(
                    imageUrl: 'assets/icons/buttons/google.png',
                    text: 'Continue with Google',
                    textColor: Colors.black,
                    backgroundColor: Colors.grey[100]!,
                    callback: () async {
                      final user = await ref.read(authManagerProvider).signInWithGoogle();

                      if (user != null) {
                        final appUser = AppUser.fromFirebaseUser(user);
                        // Add to user user list
                        ref.read(firestoreServiceProvider).addAsNewUser(appUser: appUser);
                      }
                    },
                  ),


                  SignInButton(
                    imageUrl: 'assets/icons/buttons/person.png',
                    text: 'Email & Password',
                    textColor: Colors.black,
                    backgroundColor: Colors.grey[100]!,
                    callback: () async {
                      final user = await ref.read(authManagerProvider).signInWithGoogle();

                      if (user != null) {
                        final appUser = AppUser.fromFirebaseUser(user);
                        // Add to user user list
                        ref.read(firestoreServiceProvider).addAsNewUser(appUser: appUser);
                      }
                    },
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
