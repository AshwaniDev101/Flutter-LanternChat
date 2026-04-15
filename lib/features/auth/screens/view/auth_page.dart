import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/auth/screens/view/widgets/sign_in_button.dart';
import 'package:lanternchat/features/auth/screens/viewmodel/auth_viewmodel.dart';

import '../../../../core/services/firebase/provider/firebase_providers.dart';
import '../../../../models/users/app_user.dart';
import '../../provider/auth_provider.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authViewModelProvider);
    final viewModel = ref.read(authViewModelProvider.notifier);

    // why previousAuthState is nullable?
    // On the very first time the listener is registered (when the widget is first built), there is no previous value yet.
    ref.listen(authViewModelProvider, (prev, next) {
      next.whenOrNull(
        // data: (_) {
        //   // Navigate to home
        //   Navigator.pushReplacementNamed(context, '/home');
        // },

        error: (err, t) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
        },
      );
    });

    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(Icons.wechat_outlined, size: 40, color: Colors.blueGrey[400]),
            Image.asset('assets/icons/main/lantern_icon.png', width: 52, height: 52, fit: BoxFit.contain),
            SizedBox(height: 20),

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
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: SignInButton(
                      imageUrl: 'assets/icons/buttons/google.png',
                      text: 'Continue with Google',
                      textColor: Colors.black,
                      backgroundColor: Colors.grey[100]!,
                      callback: authState.isLoading
                          ? null
                          : () {
                              viewModel.googleSignIn();
                            },
                    ),
                  ),

                  if (authState.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(),
                    ),

                  // SignInButton(
                  //   imageUrl: 'assets/icons/buttons/person.png',
                  //   text: 'Email & Password',
                  //   textColor: Colors.black,
                  //   backgroundColor: Colors.grey[100]!,
                  //   callback: () async {
                  //     final user = await ref.read(authManagerProvider).signInWithGoogle();
                  //
                  //     if (user != null) {
                  //       final appUser = AppUser.fromFirebaseUser(user);
                  //       // Add to user user list
                  //       ref.read(firestoreServiceProvider).addAsNewUser(appUser: appUser);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
